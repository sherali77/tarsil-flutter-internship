class Note {
  final int id;
  final String title;
  final String content;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Note copyWith({
    int? id,
    String? title,
    String? content,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'category': category,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'] is int ? json['id']: int.tryParse(json['id']?.toString() ?? '') ?? 0,
        title: json['title'] ?? '',
        content: json['content'] ?? '',
        category: json['category'] ?? '',
        createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']): DateTime.now(),
        updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']): DateTime.now(),
      );
}