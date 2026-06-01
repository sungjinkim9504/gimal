import 'package:shared_preferences/shared_preferences.dart';
import '../models/diary_entry.dart';

class DiaryRepository {
  static const _key = 'diary_entries';

  Future<List<DiaryEntry>> getAllEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    final entries = jsonList.map(DiaryEntry.fromJsonString).toList();
    entries.sort((a, b) => b.date.compareTo(a.date));
    return entries;
  }

  Future<void> saveEntry(DiaryEntry entry) async {
    final entries = await getAllEntries();
    final index = entries.indexWhere((e) => e.id == entry.id);
    if (index >= 0) {
      entries[index] = entry;
    } else {
      entries.add(entry);
    }
    await _saveAll(entries);
  }

  Future<void> deleteEntry(String id) async {
    final entries = await getAllEntries();
    entries.removeWhere((e) => e.id == id);
    await _saveAll(entries);
  }

  Future<void> _saveAll(List<DiaryEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, entries.map((e) => e.toJsonString()).toList());
  }
}
