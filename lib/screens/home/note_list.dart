import 'package:ez_notes/models/note.dart';
import 'package:ez_notes/screens/home/note_editor.dart';
import 'package:ez_notes/services/auth.dart';
import 'package:ez_notes/services/database.dart';
import 'package:ez_notes/shared/constant.dart';
import 'package:ez_notes/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ez_notes/screens/home/home.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List<int> slctItems = [];
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<List<Note>>(context);
    // final reminders = Provider.of<List<Reminder>>(context);
    //TODO: List catégories ?

    // DatabaseService(_auth.userId).assignReminders(reminders, notes);
    return (notes == [])
        ? Loading()
        : ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Container(
                color: (slctItems.contains(index))
                    ? colorTheme.withOpacity(0.5)
                    : Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
                    child: ListTile(
                      onTap: () {
                        if (slctItems.contains(index)) {
                          setState(() {
                            slctItems.removeWhere((val) => val == index);
                          });
                          Home.of(context)?.selectedItems = slctItems;
                        } else {
                          if (slctItems.isNotEmpty) {
                            setState(() {
                              slctItems.add(index);
                            });
                            Home.of(context)?.selectedItems = slctItems;
                          } else {
                            // open note editor
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NoteEditor(note: notes[index]),
                              ),
                            );
                          }
                        }
                      },
                      onLongPress: () {
                        if (!slctItems.contains(index)) {
                          setState(() {
                            slctItems.add(index);
                          });
                          Home.of(context)?.selectedItems = slctItems;
                        }
                      },
                      tileColor: bgColorTheme2,
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: bgColorTheme, // note color
                      ),
                      title: Text(notes[index].title),
                      subtitle: Text((() {
                        if (notes[index].content.isEmpty) {
                          return "";
                        }
                        String subtitre = (notes[index].content.length < 20)
                            ? notes[index].content
                            : notes[index].content.substring(0, 20) + "...";
                        return subtitre;
                      })()),
                      // TODO: favorites mark ?
                      // trailing: (notes[index].reminder != null)
                      //     ? Icon(Icons.alarm, color: bgColorTheme)
                      //     : null,
                    ),
                  ),
                ),
              );
            },
          );
  }
}
