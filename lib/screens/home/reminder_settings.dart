import 'package:ez_notes/models/note.dart';
import 'package:flutter/material.dart';
import 'package:ez_notes/shared/constant.dart';
import 'package:ez_notes/shared/input_decoration_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ReminderSettings extends StatefulWidget {
  final Note note;

  ReminderSettings(this.note);

  @override
  _ReminderSettingsState createState() => _ReminderSettingsState(note);
}

class _ReminderSettingsState extends State<ReminderSettings> {
  final Note note;
  final _formKey = GlobalKey<FormState>();

  _ReminderSettingsState(this.note);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Center(
            child: Text('Changez les paramètres du rappel.',
                style: GoogleFonts.outfit(
                  fontSize: 16.0,
                  color: Colors.white,
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            initialValue: note.reminder?.title ?? 'Sans titre',
            cursorColor: colorTheme,
            decoration: customDeco(helperText: "Titre", border: 'u'),
            style: GoogleFonts.outfit(color: Colors.white),
            validator: (val) =>
                val!.isEmpty ? 'Veuillez entrer un titre.' : null,
            onChanged: (val) => setState((() => note.reminder!.title = val)),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            maxLines: 50,
            minLines: 1,
            initialValue: note.reminder?.content ?? '',
            cursorColor: colorTheme,
            decoration: customDeco(helperText: "Contenu", border: 'u'),
            style: GoogleFonts.outfit(color: Colors.white),
            validator: (val) => null,
            onChanged: (val) => setState((() => note.reminder!.content = val)),
          ),
          SizedBox(height: 20.0),
          TextButton(
            onPressed: () {
              DatePicker.showDateTimePicker(context, locale: LocaleType.fr,
                  onConfirm: (date) {
                note.reminder!.dueDate = date.toString();
                print(note.reminder!.dueDate);
              });
            },
            child: Text("Changer l'heure"),
          ),
          SizedBox(height: 20.0),
          // boutton validation
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: colorTheme,
              shape: StadiumBorder(),
            ),
            child: Text(
              'Update',
              style: GoogleFonts.outfit(color: bgColorTheme),
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
