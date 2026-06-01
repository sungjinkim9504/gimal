import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/diary_entry.dart';
import '../providers/diary_provider.dart';
import '../widgets/emotion_badge.dart';
import '../../ai/providers/ai_provider.dart';
import 'diary_list_screen.dart';

class DiaryDetailScreen extends ConsumerWidget {
  static const String routeName = 'diary-detail';

  final String id;

  const DiaryDetailScreen({super.key, required this.id});

  String _formatDate(DateTime d) {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    final w = weekdays[d.weekday - 1];
    return '${d.year}년 ${d.month}월 ${d.day}일 $w요일';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(diaryNotifierProvider);
    final matching = entries.where((e) => e.id == id);

    if (matching.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('일기를 찾을 수 없습니다')),
      );
    }

    final entry = matching.first;
    final aiState = ref.watch(generateAiCommentProvider(id));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_formatDate(entry.date)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push(
              '/diary/write',
              extra: DiaryWriteArgs(
                date: entry.date,
                existingEntry: entry,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context, ref, entry),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 일기 내용
            Text(
              entry.content,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.8),
            ),
            const SizedBox(height: 32),

            // AI 코멘트 영역
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'AI의 한마디',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      if (entry.aiComment != null)
                        EmotionBadge(emotion: entry.emotion, size: 28),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildAiCommentBody(context, entry, aiState),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAiCommentBody(
    BuildContext context,
    DiaryEntry entry,
    AsyncValue<void> aiState,
  ) {
    final theme = Theme.of(context);

    if (entry.aiComment != null) {
      return Text(
        entry.aiComment!,
        style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
      );
    }

    return aiState.when(
      loading: () => Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'AI가 분석 중이에요...',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      data: (_) => const SizedBox.shrink(),
      error: (e, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            e.toString().replaceFirst('Exception: ', ''),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            icon: const Icon(Icons.settings_outlined, size: 14),
            label: const Text('설정으로 이동'),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    DiaryEntry entry,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('일기 삭제'),
        content: const Text('이 일기를 삭제할까요?'),
        actions: [
          TextButton(
            onPressed: () => ctx.pop(false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => ctx.pop(true),
            child: Text(
              '삭제',
              style: TextStyle(color: Theme.of(ctx).colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(diaryNotifierProvider.notifier).deleteEntry(entry.id);
      if (context.mounted) context.pop();
    }
  }
}
