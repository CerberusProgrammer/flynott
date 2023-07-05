class Note {
  int index;
  String title;
  String date;
  String content;

  Note({
    required this.index,
    required this.title,
    required this.date,
    required this.content,
  });

  Note copyWith({
    int? index,
    String? title,
    String? date,
    String? content,
  }) {
    return Note(
      index: index ?? this.index,
      title: title ?? this.title,
      date: date ?? this.date,
      content: content ?? this.content,
    );
  }
}
