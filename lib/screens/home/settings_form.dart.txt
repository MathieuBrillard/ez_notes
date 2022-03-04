import 'package:ez_notes/models/user.dart';
import 'package:ez_notes/services/auth.dart';
import 'package:ez_notes/services/database.dart';
import 'package:ez_notes/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ez_notes/shared/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final String userID = AuthService().userId;

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: userID).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Text('Changez les paramètres de votre boisson.',
                        style: GoogleFonts.outfit(fontSize: 16.0)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: _currentName ?? userData?.name,
                    cursorColor: colorTheme,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Veuillez entrer un nom.' : null,
                    onChanged: (val) => setState((() => _currentName = val)),
                  ),
                  SizedBox(height: 20.0),
                  // dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData?.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugar(s)'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState((() => _currentSugars = val.toString())),
                  ),
                  SizedBox(height: 20.0),
                  // slider
                  Slider(
                      min: 100,
                      max: 900,
                      divisions: 8,
                      value:
                          (_currentStrength ?? userData?.strength)!.toDouble(),
                      activeColor: colorTheme,
                      inactiveColor: bgColorTheme,
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round())),
                  SizedBox(
                    height: 20.0,
                  ),
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
                        await DatabaseService(uid: userID).updateUserData(
                          _currentName ?? userData!.name,
                          _currentSugars ?? userData!.sugars,
                          _currentStrength ?? userData!.strength,
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
        });
  }
}
