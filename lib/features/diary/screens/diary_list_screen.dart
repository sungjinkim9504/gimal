import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/diary_entry.dart';
import '../providers/diary_provider.dart';
import '../widgets/diary_card.dart';

class DiaryListScreen extends ConsumerStatefulWidget {
  static const String routeName = 'diary-list';

  const DiaryListScreen({super.key});

  @override
  ConsumerState<DiaryListScreen> createState() => _DiaryListScreenState();
}

class _DiaryListScreenState extends ConsumerState<DiaryListScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<DiaryEntry> _entriesForDay(List<DiaryEntry> all, DateTime day) {
    return all
        .where((e) =>
            e.date.year == day.year &&
            e.date.month == day.month &&
            e.date.day == day.day)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(diaryNotifierProvider);
    final selectedEntries = _entriesForDay(entries, _selectedDay);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('감정 일기'),
      ),
      body: Column(
        children: [
          TableCalendar<DiaryEntry>(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: CalendarFormat.month,
            availableCalendarFormats: const {CalendarFormat.month: '월'},
            headerStyle: const HeaderStyle(formatButtonVisible: false),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) => _entriesForDay(entries, day),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (events.isEmpty) return null;
                return Wrap(
                  alignment: WrapAlignment.center,
                  children: events.take(3).map((e) {
                    return Text(e.emotion,
                        style: const TextStyle(fontSize: 10));
                  }).toList(),
                );
              },
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: selectedEntries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('✏️',
                            style: const TextStyle(fontSize: 40)),
                        const SizedBox(height: 12),
                        Text(
                          '이날의 일기가 없어요\n지금 기록해 보세요!',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: selectedEntries.length,
                    itemBuilder: (_, i) =>
                        DiaryCard(entry: selectedEntries[i]),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(
          '/diary/write',
          extra: DiaryWriteArgs(date: _selectedDay),
        ),
        child: const Icon(Icons.edit_outlined),
      ),
    );
  }
}

class DiaryWriteArgs {
  final DateTime date;
  final DiaryEntry? existingEntry;

  const DiaryWriteArgs({required this.date, this.existingEntry});
}
