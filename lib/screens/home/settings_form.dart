import 'package:ez_notes/models/user.dart';
import 'package:ez_notes/services/auth.dart';
import 'package:ez_notes/services/database.dart';
import 'package:ez_notes/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ez_notes/shared/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsForm extends StatefulWidget {
  final UserData? _userData;

  SettingsForm(this._userData);

  @override
  _SettingsFormState createState() => _SettingsFormState(_userData);
}

class _SettingsFormState extends State<SettingsForm> {
  final UserData? _userData;

  _SettingsFormState(this._userData);

  final _formKey = GlobalKey<FormState>();

  // form values
  String? _currentName;

  @override
  Widget build(BuildContext context) {
    final String userID = AuthService().userId;

    if (_userData != null) {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: Text('Changez les paramètres de votre compte.',
                  style: GoogleFonts.outfit(
                    fontSize: 16.0,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              initialValue: _currentName ?? _userData?.name,
              cursorColor: colorTheme,
              decoration: textInputDecoration,
              style: GoogleFonts.outfit(color: Colors.white),
              validator: (val) =>
                  val!.isEmpty ? 'Veuillez entrer un nom.' : null,
              onChanged: (val) => setState((() => _currentName = val)),
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
                if (_formKey.currentState!.validate()) {
                  await DatabaseService(userID).updateUsername(
                    _currentName ?? _userData!.name,
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );
    } else {
      return Loading();
    }
  }
}
