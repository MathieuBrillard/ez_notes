class Note {
  String id;
  String title;
  String content;
  String noteColor;

  Note({
    required this.id,
    this.title = "Nouvelle note",
    this.content = "",
    this.noteColor = 'dark',
  });
}

// class Reminder {
//   String id;
//   String noteId;
//   String title;
//   String content;
//   String dueDate;

//   Reminder({
//     required this.id,
//     required this.noteId,
//     required this.title,
//     this.content = "",
//     required this.dueDate,
//   });
// }
