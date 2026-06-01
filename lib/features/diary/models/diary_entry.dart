import 'dart:convert';

class DiaryEntry {
  final String id;
  final DateTime date;
  final String content;
  final String? aiComment;
  final String emotion;
  final DateTime createdAt;

  const DiaryEntry({
    required this.id,
    required this.date,
    required this.content,
    this.aiComment,
    this.emotion = '😐',
    required this.createdAt,
  });

  DiaryEntry copyWith({
    String? id,
    DateTime? date,
    String? content,
    String? aiComment,
    String? emotion,
    DateTime? createdAt,
  }) {
    return DiaryEntry(
      id: id ?? this.id,
      date: date ?? this.date,
      content: content ?? this.content,
      aiComment: aiComment ?? this.aiComment,
      emotion: emotion ?? this.emotion,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'content': content,
        'aiComment': aiComment,
        'emotion': emotion,
        'createdAt': createdAt.toIso8601String(),
      };

  factory DiaryEntry.fromJson(Map<String, dynamic> json) => DiaryEntry(
        id: json['id'] as String,
        date: DateTime.parse(json['date'] as String),
        content: json['content'] as String,
        aiComment: json['aiComment'] as String?,
        emotion: (json['emotion'] as String?) ?? '😐',
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  String toJsonString() => jsonEncode(toJson());
  factory DiaryEntry.fromJsonString(String s) =>
      DiaryEntry.fromJson(jsonDecode(s) as Map<String, dynamic>);
}
