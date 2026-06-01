import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/diary_entry.dart';
import '../repositories/diary_repository.dart';

final diaryRepositoryProvider = Provider<DiaryRepository>((_) => DiaryRepository());

final diaryNotifierProvider =
    StateNotifierProvider<DiaryNotifier, List<DiaryEntry>>((ref) {
  return DiaryNotifier(ref.read(diaryRepositoryProvider));
});

class DiaryNotifier extends StateNotifier<List<DiaryEntry>> {
  DiaryNotifier(this._repository) : super(const []) {
    _load();
  }

  final DiaryRepository _repository;

  Future<void> _load() async {
    state = await _repository.getAllEntries();
  }

  Future<DiaryEntry> addEntry({
    required String content,
    required DateTime date,
  }) async {
    final entry = DiaryEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: date,
      content: content,
      createdAt: DateTime.now(),
    );
    await _repository.saveEntry(entry);
    state = [entry, ...state];
    return entry;
  }

  Future<void> updateEntry(DiaryEntry entry) async {
    await _repository.saveEntry(entry);
    state = state.map((e) => e.id == entry.id ? entry : e).toList();
  }

  Future<void> deleteEntry(String id) async {
    await _repository.deleteEntry(id);
    state = state.where((e) => e.id != id).toList();
  }
}
