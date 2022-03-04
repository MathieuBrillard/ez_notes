import 'package:ez_notes/screens/home/reminder_settings.dart';
import 'package:ez_notes/services/auth.dart';
import 'package:ez_notes/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:ez_notes/models/note.dart';
import 'package:ez_notes/services/database.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:io' show Platform;

class NoteEditor extends StatefulWidget {
  final Note note;

  NoteEditor({required this.note});

  @override
  State<NoteEditor> createState() => _NoteEditorState(note: note);
}

class _NoteEditorState extends State<NoteEditor> {
  final Note note;
  final AuthService _auth = AuthService();

  _NoteEditorState({required this.note});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void _showReminderPanel() {
      if (note.reminder == null) {
        DatabaseService(_auth.userId)
            .createReminder(note, 'Sans titre', '', '');
      }
      showModalBottomSheet(
        context: context,
        backgroundColor: bgColorTheme,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ReminderSettings(note),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: colorTheme,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: bgColorTheme,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_alarm_rounded,
              color: bgColorTheme,
            ),
            onPressed: () {
              // if (Platform.isWindows) {
              //   print("windows platform");
              //   ElegantNotification(
              //     icon: Icon(Icons.access_alarm_rounded),
              //     title: Text("Rappel"),
              //     description: Text("Vous devez aller chez le médecin !"),
              //     notificationPosition: NOTIFICATION_POSITION.bottom,
              //     displayCloseButton: true,
              //     toastDuration: Duration(seconds: 7),
              //   ).show(context);
              // } else if (Platform.isAndroid) {
              //   print("android platform");
              // }
              _showReminderPanel();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.save,
              color: bgColorTheme,
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await DatabaseService(_auth.userId).updateNote(note);
              }
            },
          )
        ],
      ),
      backgroundColor: bgColorTheme,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 300.0,
                    child: TextFormField(
                      initialValue: note.title,
                      cursorColor: colorTheme,
                      decoration: textInputDecoration,
                      style: GoogleFonts.outfit(color: Colors.white),
                      textAlign: TextAlign.center,
                      validator: (val) =>
                          val!.isEmpty ? 'Veuillez entrer un titre.' : null,
                      onChanged: (val) => note.title = val,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: TextFormField(
                    initialValue: note.content,
                    cursorColor: colorTheme,
                    decoration: textInputDecoration,
                    style: GoogleFonts.outfit(color: Colors.white),
                    maxLines: 5000,
                    minLines: 5,
                    validator: null,
                    onChanged: (val) => note.content = val,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
