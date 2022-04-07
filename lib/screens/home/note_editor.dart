import 'package:ez_notes/services/auth.dart';
import 'package:ez_notes/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:ez_notes/models/note.dart';
import 'package:ez_notes/services/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
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

  final TextEditingController _controller = TextEditingController();

  bool showEditor = false;

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: MarkdownBody(
                    data: note.content,
                    styleSheet: mdStyleSheet,
                    listItemCrossAxisAlignment:
                        MarkdownListItemCrossAxisAlignment.baseline,
                    shrinkWrap: true,
                    fitContent: false,
                    softLineBreak: true,
                    selectable: true,
                  ),
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: (showEditor) ? true : false,
                  maintainState: true,
                  child: LayoutBuilder(builder: (context, constraints) {
                    var parentMaxWidth = constraints.maxWidth;
                    return Container(
                      width: ((parentMaxWidth * 0.3) > 200)
                          ? parentMaxWidth * 0.3
                          : parentMaxWidth,
                      child: Column(
                        children: [
                          MarkdownTextInput(
                            (String value) => setState(() {
                              note.content = value;
                            }),
                            note.content,
                            label: 'Editeur de la note',
                            maxLines: 10,
                            actions: [
                              MarkdownType.bold,
                              MarkdownType.italic,
                              MarkdownType.title,
                              MarkdownType.list,
                              MarkdownType.link,
                              MarkdownType.separator,
                              MarkdownType.code,
                              MarkdownType.blockquote,
                            ],
                            controller: _controller,
                            validators: (value) {
                              note.content = value ?? '';
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(primary: colorTheme),
                            onPressed: () {
                              _controller.clear();
                              note.content = '';
                            },
                            child: Text('Clear'),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showEditor = !showEditor;
          });
        },
        child: Icon(
          (showEditor) ? Icons.edit_off_rounded : Icons.edit_rounded,
          color: bgColorTheme,
          size: 40,
        ),
        backgroundColor: colorTheme,
      ),
    );
  }
}
