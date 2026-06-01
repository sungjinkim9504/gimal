import 'dart:convert';
import 'package:dio/dio.dart';

class AiResult {
  final String emotion;
  final String comment;

  const AiResult({required this.emotion, required this.comment});
}

class ClaudeService {
  static const _endpoint = 'https://api.anthropic.com/v1/messages';
  static const _model = 'claude-haiku-4-5-20251001';
  static const _systemPrompt = '''
당신은 따뜻하고 공감 능력이 뛰어난 감정 일기 상담사입니다.
사용자가 오늘 있었던 일을 일기로 적으면:

1. 일기에서 느껴지는 전반적인 감정을 이모지 하나로 표현하세요
2. 따뜻하고 진심 어린 조언을 2-3문장으로 한국어로 작성하세요

사용 가능한 감정 이모지: 😊 😢 😠 😰 😴 😍 🥳 😤 😔 🤔

다음 JSON 형식으로만 응답하세요 (다른 텍스트 없이):
{"emotion": "이모지", "comment": "조언 내용"}
''';

  final Dio _dio;

  ClaudeService() : _dio = Dio();

  Future<AiResult> analyze(String diaryContent, String apiKey) async {
    final response = await _dio.post(
      _endpoint,
      options: Options(
        headers: {
          'x-api-key': apiKey,
          'anthropic-version': '2023-06-01',
          'content-type': 'application/json',
        },
      ),
      data: {
        'model': _model,
        'max_tokens': 300,
        'system': _systemPrompt,
        'messages': [
          {'role': 'user', 'content': diaryContent},
        ],
      },
    );

    final text = (response.data['content'] as List).first['text'] as String;
    return _parseResult(text);
  }

  AiResult _parseResult(String text) {
    // JSON 블록이 마크다운으로 감싸진 경우 제거
    final cleaned = text
        .replaceAll('```json', '')
        .replaceAll('```', '')
        .trim();

    try {
      final json = jsonDecode(cleaned) as Map<String, dynamic>;
      return AiResult(
        emotion: (json['emotion'] as String?) ?? '😐',
        comment: (json['comment'] as String?) ?? '오늘 하루도 고생하셨어요.',
      );
    } catch (_) {
      return AiResult(emotion: '😐', comment: text.trim());
    }
  }
}
