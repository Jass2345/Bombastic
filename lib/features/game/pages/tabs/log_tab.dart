import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/bomb_repository.dart';
import '../../../group/controllers/group_controller.dart';

part 'log_tab.g.dart';

@riverpod
Stream<List<Map<String, dynamic>>> passLogs(Ref ref, String groupId) {
  return ref.watch(bombRepositoryProvider).watchPassLogs(groupId);
}

class LogTab extends ConsumerWidget {
  const LogTab({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(passLogsProvider(groupId));
    final group = ref.watch(watchGroupProvider(groupId)).asData?.value;
    final nicknames = group?.memberNicknames ?? {};

    return logsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('오류: $e')),
      data: (logs) {
        if (logs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('📋', style: TextStyle(fontSize: 48)),
                SizedBox(height: 12),
                Text('아직 기록이 없습니다.',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }

        // 날짜별 그룹핑
        final grouped = <String, List<Map<String, dynamic>>>{};
        for (final log in logs) {
          final ts = log['timestamp'];
          DateTime? dt;
          if (ts is Timestamp) dt = ts.toDate().toLocal();
          final dateKey = dt != null
              ? '${dt.year}.${dt.month.toString().padLeft(2, '0')}.${dt.day.toString().padLeft(2, '0')}'
              : '날짜 없음';
          grouped.putIfAbsent(dateKey, () => []).add(log);
        }

        final dateKeys = grouped.keys.toList();

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: dateKeys.length,
          itemBuilder: (_, i) {
            final date = dateKeys[i];
            final entries = grouped[date]!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ...entries.map((log) {
                  final ts = log['timestamp'];
                  DateTime? dt;
                  if (ts is Timestamp) dt = ts.toDate().toLocal();
                  final timeStr = dt != null
                      ? '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}'
                      : '--:--';

                  final fromUid = log['fromUid'] as String? ?? '';
                  final toUid = log['toUid'] as String? ?? '';
                  final fromNick = nicknames[fromUid] ?? fromUid;
                  final toNick = nicknames[toUid] ?? toUid;

                  return ListTile(
                    dense: true,
                    leading: Text(
                      timeStr,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey),
                    ),
                    title: Text(
                      '$fromNick님이 $toNick님에게 폭탄을 전달했습니다.',
                      style: const TextStyle(fontSize: 13),
                    ),
                  );
                }),
              ],
            );
          },
        );
      },
    );
  }
}
