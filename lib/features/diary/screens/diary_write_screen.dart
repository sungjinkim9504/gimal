import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/diary_entry.dart';
import '../providers/diary_provider.dart';

class DiaryWriteScreen extends ConsumerStatefulWidget {
  static const String routeName = 'diary-write';

  final DateTime date;
  final DiaryEntry? existingEntry;

  const DiaryWriteScreen({
    super.key,
    required this.date,
    this.existingEntry,
  });

  @override
  ConsumerState<DiaryWriteScreen> createState() => _DiaryWriteScreenState();
}

class _DiaryWriteScreenState extends ConsumerState<DiaryWriteScreen> {
  late final TextEditingController _controller;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.existingEntry?.content ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    final w = weekdays[d.weekday - 1];
    return '${d.year}년 ${d.month}월 ${d.day}일 $w요일';
  }

  Future<void> _save() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _isSaving = true);
    try {
      if (widget.existingEntry != null) {
        final updated = widget.existingEntry!.copyWith(
          content: text,
          aiComment: null, // 내용 수정 시 AI 코멘트 재생성
          emotion: '😐',
        );
        await ref.read(diaryNotifierProvider.notifier).updateEntry(updated);
        if (mounted) context.pop();
      } else {
        final entry = await ref.read(diaryNotifierProvider.notifier).addEntry(
              content: text,
              date: widget.date,
            );
        if (mounted) {
          context.pop();
          context.push('/diary/${entry.id}');
        }
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.existingEntry != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(_formatDate(widget.date)),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _save,
            child: _isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    isEditing ? '수정' : '저장',
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText:
                      '오늘 어떤 하루를 보내셨나요?\n자유롭게 마음을 털어놓아 보세요...',
                  hintStyle: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.7,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  fillColor: Colors.transparent,
                ),
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.8),
                autofocus: true,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _controller,
              builder: (_, value, __) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  '${value.text.length}자',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
