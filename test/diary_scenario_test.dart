import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_gimal/features/diary/providers/diary_provider.dart';

void main() {
  group('시나리오: 일기 작성 → 저장 → 조회', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('일기를 추가하면 state에 즉시 반영된다', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(diaryNotifierProvider.notifier);

      expect(container.read(diaryNotifierProvider), isEmpty);

      await notifier.addEntry(
        content: '오늘은 발표를 했다',
        date: DateTime(2026, 6, 8),
      );

      final entries = container.read(diaryNotifierProvider);
      expect(entries.length, 1);
      expect(entries.first.content, '오늘은 발표를 했다');
      expect(entries.first.aiComment, isNull);
    });

    test('일기를 수정하면 content가 업데이트된다', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(diaryNotifierProvider.notifier);
      final entry = await notifier.addEntry(
        content: '원본 내용',
        date: DateTime(2026, 6, 8),
      );

      final updated = entry.copyWith(content: '수정된 내용');
      await notifier.updateEntry(updated);

      final entries = container.read(diaryNotifierProvider);
      expect(entries.first.content, '수정된 내용');
    });

    test('일기를 삭제하면 목록에서 제거된다', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(diaryNotifierProvider.notifier);
      final entry = await notifier.addEntry(
        content: '삭제할 일기',
        date: DateTime(2026, 6, 8),
      );

      await notifier.deleteEntry(entry.id);

      expect(container.read(diaryNotifierProvider), isEmpty);
    });
  });
}
