import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

import { bombDefaultDurationSeconds } from '../core/gameConfig';

const db = admin.firestore();

/**
 * 폭탄 전달 Callable Function.
 * data: { groupId: string, bombId: string }
 *
 * expiresAt을 서버 시간(admin.firestore.Timestamp.now()) 기준으로 계산하여
 * 기기 클럭 차이에 의한 유저 간 타이머 불일치를 방지한다.
 * pass 로그(passes 서브컬렉션)도 같은 트랜잭션에서 기록한다.
 */
export const passBomb = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', '로그인이 필요합니다.');
  }

  const { groupId, bombId } = data as { groupId: string; bombId: string };
  const uid = context.auth.uid;

  if (!groupId || !bombId) {
    throw new functions.https.HttpsError('invalid-argument', 'groupId와 bombId가 필요합니다.');
  }

  const groupRef = db.collection('groups').doc(groupId);
  const bombRef = groupRef.collection('bombs').doc(bombId);

  await db.runTransaction(async (tx) => {
    const [groupSnap, bombSnap] = await Promise.all([
      tx.get(groupRef),
      tx.get(bombRef),
    ]);

    const group = groupSnap.data();
    const bomb = bombSnap.data();

    if (!bomb || bomb.status !== 'active') {
      throw new functions.https.HttpsError('failed-precondition', '활성 폭탄이 없습니다.');
    }
    if (bomb.holderUid !== uid) {
      throw new functions.https.HttpsError('permission-denied', '폭탄 보유자만 전달할 수 있습니다.');
    }

    const memberUids: string[] = Array.isArray(group?.memberUids) ? group!.memberUids : [];
    const currentIndex = memberUids.indexOf(uid);
    if (currentIndex === -1) {
      throw new functions.https.HttpsError('failed-precondition', '그룹 멤버가 아닙니다.');
    }

    const nextUid = memberUids[(currentIndex + 1) % memberUids.length];

    // 서버 시간 기준 expiresAt 설정 — 기기 클럭 무관
    const now = admin.firestore.Timestamp.now();
    const expiresAt = new admin.firestore.Timestamp(
      now.seconds + bombDefaultDurationSeconds,
      now.nanoseconds,
    );

    tx.update(bombRef, {
      holderUid: nextUid,
      receivedAt: admin.firestore.FieldValue.serverTimestamp(),
      expiresAt,
    });

    // pass 로그 (트랜잭션 내 기록으로 원자성 보장)
    const passRef = groupRef.collection('passes').doc();
    tx.set(passRef, {
      fromUid: uid,
      toUid: nextUid,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  return { success: true };
});
