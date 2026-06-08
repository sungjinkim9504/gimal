import 'package:flutter_test/flutter_test.dart';
import 'package:project_gimal/features/diary/models/diary_entry.dart';

void main() {
  final base = DiaryEntry(
    id: '1',
    date: DateTime(2026, 6, 8),
    content: '오늘은 발표를 했다',
    createdAt: DateTime(2026, 6, 8, 22, 0),
  );

  group('DiaryEntry.copyWith', () {
    test('aiComment를 null로 초기화할 수 없다 (copyWith 한계 확인)', () {
      final withComment = base.copyWith(aiComment: '잘 했어요!', emotion: '😊');
      // copyWith으로 null 전달 시 기존 값 유지 (Dart nullable 특성)
      final again = withComment.copyWith(content: '수정된 내용');
      expect(again.aiComment, '잘 했어요!');
      expect(again.content, '수정된 내용');
    });

    test('content만 변경 시 나머지 필드는 유지된다', () {
      final updated = base.copyWith(content: '새로운 내용');
      expect(updated.id, base.id);
      expect(updated.date, base.date);
      expect(updated.content, '새로운 내용');
      expect(updated.emotion, base.emotion);
    });
  });

  group('DiaryEntry JSON 직렬화', () {
    test('toJson → fromJson 왕복 시 동일 객체가 복원된다', () {
      final entry = base.copyWith(aiComment: '따뜻한 하루였네요.', emotion: '😊');
      final json = entry.toJson();
      final restored = DiaryEntry.fromJson(json);

      expect(restored.id, entry.id);
      expect(restored.content, entry.content);
      expect(restored.aiComment, entry.aiComment);
      expect(restored.emotion, entry.emotion);
      expect(restored.date, entry.date);
    });

    test('aiComment가 null인 경우에도 직렬화/역직렬화가 정상 동작한다', () {
      final json = base.toJson();
      final restored = DiaryEntry.fromJson(json);
      expect(restored.aiComment, isNull);
    });

    test('toJsonString → fromJsonString 왕복 시 동일 객체가 복원된다', () {
      final jsonStr = base.toJsonString();
      final restored = DiaryEntry.fromJsonString(jsonStr);
      expect(restored.id, base.id);
      expect(restored.content, base.content);
    });

    test('emotion 필드 누락 시 기본값 😐이 사용된다', () {
      final json = base.toJson()..remove('emotion');
      final restored = DiaryEntry.fromJson(json);
      expect(restored.emotion, '😐');
    });
  });
}
