import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme_provider.dart';
import '../../../../data/firebase/firebase_providers.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../group/controllers/group_controller.dart';

class SettingsTab extends ConsumerStatefulWidget {
  const SettingsTab({super.key, required this.groupId});

  final String groupId;

  @override
  ConsumerState<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends ConsumerState<SettingsTab> {
  late TextEditingController _nicknameCtrl;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final group =
        ref.read(watchGroupProvider(widget.groupId)).asData?.value;
    final uid = ref.read(currentUidProvider) ?? '';
    final currentNick = group?.memberNicknames[uid] ?? '';
    _nicknameCtrl = TextEditingController(text: currentNick);
  }

  @override
  void dispose() {
    _nicknameCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveNickname() async {
    final uid = ref.read(currentUidProvider);
    if (uid == null || _nicknameCtrl.text.trim().isEmpty) return;

    setState(() => _isSaving = true);
    try {
      await ref.read(userRepositoryProvider).updateGroupNickname(
            uid: uid,
            groupId: widget.groupId,
            nickname: _nicknameCtrl.text.trim(),
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('닉네임이 변경됐습니다.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('저장 실패: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 닉네임 변경
        const Text(
          '닉네임',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
              color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _nicknameCtrl,
                  decoration: const InputDecoration(
                    labelText: '이 그룹에서 사용할 닉네임',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 10,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _isSaving ? null : _saveNickname,
                  child: _isSaving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('저장'),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // 테마 설정
        const Text(
          '테마',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
              color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              RadioListTile<ThemeMode>(
                title: const Text('시스템 설정 따름'),
                value: ThemeMode.system,
                groupValue: themeMode,
                onChanged: (v) =>
                    ref.read(themeModeProvider.notifier)
                        .setMode(v!),
              ),
              RadioListTile<ThemeMode>(
                title: const Text('라이트 모드'),
                value: ThemeMode.light,
                groupValue: themeMode,
                onChanged: (v) =>
                    ref.read(themeModeProvider.notifier)
                        .setMode(v!),
              ),
              RadioListTile<ThemeMode>(
                title: const Text('다크 모드'),
                value: ThemeMode.dark,
                groupValue: themeMode,
                onChanged: (v) =>
                    ref.read(themeModeProvider.notifier)
                        .setMode(v!),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
