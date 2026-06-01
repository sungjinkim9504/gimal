import 'dart:convert';
import 'package:dio/dio.dart';

class AiResult {
  final String emotion;
  final String comment;

  const AiResult({required this.emotion, required this.comment});
}

class GeminiService {
  static const _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';
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

  GeminiService() : _dio = Dio();

  Future<AiResult> analyze(String diaryContent, String apiKey) async {
    try {
      return await _request(diaryContent, apiKey);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 429) throw Exception('요청 한도를 초과했습니다. 잠시 후 다시 시도해 주세요.');
      if (status == 400) throw Exception('잘못된 요청입니다. API 키를 확인해 주세요.');
      if (status == 403) throw Exception('API 키 권한이 없습니다. 키를 다시 확인해 주세요.');
      throw Exception('네트워크 오류가 발생했습니다. (${status ?? '연결 실패'})');
    }
  }

  Future<AiResult> _request(String diaryContent, String apiKey) async {
    final response = await _dio.post(
      '$_baseUrl?key=$apiKey',
      data: {
        'system_instruction': {
          'parts': [
            {'text': _systemPrompt}
          ]
        },
        'contents': [
          {
            'role': 'user',
            'parts': [
              {'text': diaryContent}
            ]
          }
        ],
        'generationConfig': {
          'maxOutputTokens': 300,
        },
      },
    );

    final text = ((response.data['candidates'] as List).first['content']['parts']
            as List)
        .first['text'] as String;

    return _parseResult(text);
  }

  AiResult _parseResult(String text) {
    final cleaned =
        text.replaceAll('```json', '').replaceAll('```', '').trim();
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
}
