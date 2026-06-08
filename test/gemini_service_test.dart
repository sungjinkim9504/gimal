import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_gimal/features/ai/services/gemini_service.dart';

// _parseResult는 private이므로 응답 파싱 로직을 직접 검증
AiResult parseGeminiResponse(String text) {
  final cleaned = text.replaceAll('```json', '').replaceAll('```', '').trim();
  try {
    final json = jsonDecode(cleaned) as Map<String, dynamic>;
    return AiResult(
      emotion: (json['emotion'] as String?) ?? '😐',
      comment: (json['comment'] as String?) ?? '오늘도 수고하셨어요.',
    );
  } catch (_) {
    return AiResult(emotion: '😐', comment: text.trim());
  }
}

void main() {
  group('Gemini 응답 파싱', () {
    test('정상 JSON 응답을 올바르게 파싱한다', () {
      const raw = '{"emotion": "😊", "comment": "오늘 정말 잘 하셨어요!"}';
      final result = parseGeminiResponse(raw);
      expect(result.emotion, '😊');
      expect(result.comment, '오늘 정말 잘 하셨어요!');
    });

    test('마크다운 코드블록으로 감싼 JSON도 파싱된다', () {
      const raw = '```json\n{"emotion": "😢", "comment": "힘든 하루였군요."}\n```';
      final result = parseGeminiResponse(raw);
      expect(result.emotion, '😢');
      expect(result.comment, '힘든 하루였군요.');
    });

    test('emotion 키가 없으면 기본값 😐을 반환한다', () {
      const raw = '{"comment": "오늘도 수고하셨어요."}';
      final result = parseGeminiResponse(raw);
      expect(result.emotion, '😐');
    });

    test('JSON 파싱 실패 시 원문을 comment로 반환한다', () {
      const raw = '파싱 불가능한 텍스트';
      final result = parseGeminiResponse(raw);
      expect(result.emotion, '😐');
      expect(result.comment, raw);
    });

    test('AiResult 필드가 올바르게 설정된다', () {
      final result = AiResult(emotion: '🥳', comment: '축하해요!');
      expect(result.emotion, '🥳');
      expect(result.comment, '축하해요!');
    });
  });
}
