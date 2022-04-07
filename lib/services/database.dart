import 'package:ez_notes/models/note.dart';
import 'package:ez_notes/models/user.dart';
import 'package:firedart/firedart.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);

  // collection reference
  final CollectionReference noteCollection =
      Firestore.instance.collection('userData'); // collection name in firebase

  //TODO: update les collections pour les couleurs

  // create user document
  Future createUserData(String name, String email) async {
    await noteCollection.document(uid).set({
      'name': name,
      'email': email,
    });
  }

  // update username
  Future updateUsername(String name) async {
    await noteCollection.document(uid).update({
      'name': name,
    });
  }

  // create note
  Future<Note> createNote({String title = 'Sans titre'}) async {
    Document newNote =
        await noteCollection.document(uid).collection('notes').add({
      'id': '',
      'title': title,
      'content': '',
      'color': 'dark',
    });
    await noteCollection
        .document(uid)
        .collection('notes')
        .document(newNote.id)
        .update({'id': newNote.id});
    Note note =
        Note(id: newNote.id, title: title, content: '', noteColor: 'dark');
    return note;
  }

  // update note
  Future updateNote(Note note) async {
    await noteCollection
        .document(uid)
        .collection('notes')
        .document(note.id)
        .update({
      'id': note.id,
      'title': note.title,
      'content': note.content,
      'color': note.noteColor,
    });
    // if (note.reminder != null) {
    //   await noteCollection
    //       .document(uid)
    //       .collection('reminders')
    //       .document(note.reminder!.id)
    //       .update({
    //     'id': note.reminder!.id,
    //     'title': note.reminder!.title,
    //     'content': note.reminder?.content ?? '',
    //     'dueDate': note.reminder!.dueDate,
    //   });
    // }
  }

  // delete note
  Future deleteNote(Note note) async {
    await noteCollection
        .document(uid)
        .collection('notes')
        .document(note.id)
        .delete();
  }

  // create reminder
  // Future createReminder(
  //   Note note,
  //   String title,
  //   String content,
  //   String dueDate,
  // ) async {
  //   Document newReminder =
  //       await noteCollection.document(uid).collection('reminders').add({
  //     'id': '',
  //     'noteId': note.id,
  //     'title': title,
  //     'content': content,
  //     'dueDate': dueDate,
  //   });
  //   await noteCollection
  //       .document(uid)
  //       .collection('reminders')
  //       .document(newReminder.id)
  //       .update({'id': newReminder.id});
  //   note.reminder = Reminder(
  //     id: newReminder.id,
  //     noteId: note.id,
  //     title: title,
  //     content: content,
  //     dueDate: dueDate,
  //   );
  // }

  // delete reminder
  // Future deleteReminder(Note note) async {
  //   await noteCollection
  //       .document(uid)
  //       .collection('reminder')
  //       .document(note.reminder!.id)
  //       .delete();
  //   note.reminder = null;
  // }

  // get note list from document list
  List<Note> _listNoteFromDocumentList(List<Document> documents) {
    return documents.map((doc) {
      return Note(
          id: doc['id'] ?? '0',
          title: doc['title'] ?? 'Sans titre',
          content: doc['content'] ?? '',
          noteColor: doc['color'] ?? 'red');
    }).toList();
  }

  // get reminder list from document list
  // List<Reminder> _listReminderFromDocumentList(List<Document> documents) {
  //   return documents.map((doc) {
  //     return Reminder(
  //         id: doc['id'] ?? '0',
  //         noteId: doc['noteId'] ?? '0',
  //         title: doc['title'] ?? 'Sans titre',
  //         content: doc['content'] ?? '',
  //         dueDate: doc['dueDate'] ?? '');
  //   }).toList();
  // }

  // assign reminders to notes
  // void assignReminders(List<Reminder> reminders, List<Note> notes) {
  //   for (Reminder reminder in reminders) {
  //     for (Note note in notes) {
  //       if (reminder.noteId == note.id) {
  //         note.reminder = reminder;
  //       }
  //     }
  //   }
  // }

  // userData from document
  UserData _userDataFromDocument(Document? doc) {
    return UserData(uid: uid, name: doc?['name'], email: doc?['email']);
  }

  // get notes stream
  Stream<List<Note>> get notes {
    return noteCollection
        .document(uid)
        .collection('notes')
        .stream
        .map(_listNoteFromDocumentList);
  }

  // get reminders stream
  // Stream<List<Reminder>> get reminders {
  //   return noteCollection
  //       .document(uid)
  //       .collection('reminders')
  //       .stream
  //       .map(_listReminderFromDocumentList);
  // }

  // get user doc stream
  Stream<UserData> get userData {
    return noteCollection.document(uid).stream.map(_userDataFromDocument);
  }
}
