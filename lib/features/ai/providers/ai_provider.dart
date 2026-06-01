import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../services/gemini_service.dart';
import '../../diary/providers/diary_provider.dart';

final geminiServiceProvider = Provider<GeminiService>((_) => GeminiService());

final generateAiCommentProvider =
    FutureProvider.autoDispose.family<void, String>((ref, entryId) async {
  final entries = ref.read(diaryNotifierProvider);
  final matching = entries.where((e) => e.id == entryId);
  if (matching.isEmpty) return;

  final entry = matching.first;
  if (entry.aiComment != null) return;

  final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  if (apiKey.isEmpty) {
    throw Exception('.env 파일에 GEMINI_API_KEY를 설정해 주세요.');
  }

  final service = ref.read(geminiServiceProvider);
  final result = await service.analyze(entry.content, apiKey);

  await ref.read(diaryNotifierProvider.notifier).updateEntry(
        entry.copyWith(emotion: result.emotion, aiComment: result.comment),
      );
});
