import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/date_utils.dart';
import 'game_controller.dart';

part 'timer_controller.g.dart';

/// 폭탄 남은 시간을 HH:MM:SS 문자열로 제공하는 provider.
///
/// ## 기기 간 타이머 동기화 원리
/// - `bomb.expiresAt`, `bomb.receivedAt` 모두 서버 타임스탬프(Cloud Function이 기록).
/// - `totalDuration = expiresAt - receivedAt` : 서버가 정한 총 유효 시간 (기기 클럭 무관).
/// - `builtAt` : 이 provider가 빌드된 로컬 시각 — 절대값이 아닌 **기준점**으로만 사용.
/// - `elapsed = DateTime.now() - builtAt` : 로컬 시간끼리의 상대 차이이므로 클럭 오차 없음.
/// - `remaining = totalDuration - elapsed`
///
/// 폭탄이 교체(새 snapshot)될 때마다 provider가 재빌드되어 builtAt·totalDuration이 리셋된다.
@riverpod
Stream<String> bombTimer(Ref ref, String groupId) async* {
  final bomb = ref.watch(activeBombProvider(groupId)).asData?.value;
  if (bomb == null) {
    yield '00:00:00';
    return;
  }

  // 서버 타임스탬프 기반 총 유효 시간
  final totalDuration = bomb.expiresAt.difference(bomb.receivedAt);
  // provider 빌드 시각 (로컬) — elapsed 계산 기준점
  final builtAt = DateTime.now();

  yield* Stream.periodic(const Duration(seconds: 1), (_) {
    final elapsed = DateTime.now().difference(builtAt);
    final remaining = totalDuration - elapsed;
    if (remaining.isNegative) return '00:00:00';
    return AppDateUtils.formatDuration(remaining);
  });
}
