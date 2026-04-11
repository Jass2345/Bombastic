import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/admin_controller.dart';

class AdminCliDialog extends ConsumerStatefulWidget {
  const AdminCliDialog({super.key, required this.groupId});
  
  final String groupId;

  @override
  ConsumerState<AdminCliDialog> createState() => _AdminCliDialogState();
}

class _AdminCliDialogState extends ConsumerState<AdminCliDialog> {
  final _controller = TextEditingController();

  void _submit() async {
    final cmd = _controller.text.trim();
    if (cmd.isEmpty) return;
    
    await ref.read(adminControllerProvider.notifier).executeCommand(
      command: cmd,
      groupId: widget.groupId,
    );
    
    if (mounted) {
      final state = ref.read(adminControllerProvider);
      state.when(
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('✅ 명령어 실행 완료: $cmd', style: const TextStyle(fontWeight: FontWeight.bold))),
          );
          _controller.clear();
          Navigator.pop(context); // 실행 후 창 닫기 (바로 적용)
        },
        error: (e, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ 실행 실패: $e')),
        ),
        loading: () {},
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(adminControllerProvider).isLoading;
    
    return AlertDialog(
      title: const Text('👨‍💻 Admin CLI', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '명령어 리스트:\n/money [amount]\n/items\n/explode\n/mission\n/steal\n/endgame',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: '명령어 입력...',
              border: OutlineInputBorder(),
              prefixText: '> ',
            ),
            autofocus: true,
            textInputAction: TextInputAction.send,
            onSubmitted: (_) => _submit(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('닫기'),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : _submit,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
          child: isLoading 
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) 
              : const Text('실행'),
        ),
      ],
    );
  }
}
