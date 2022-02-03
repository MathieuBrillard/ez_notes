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
  String _currentName = 'Entrez un nouveau nom';
  String _currentSugars = '0';
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
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
            initialValue: _currentName,
            cursorColor: colorTheme,
            decoration: textInputDecoration,
            validator: (val) => val!.isEmpty ? 'Veuillez entrer un nom.' : null,
            onChanged: (val) => setState((() => _currentName = val)),
          ),
          SizedBox(height: 20.0),
          // dropdown
          DropdownButtonFormField(
            decoration: textInputDecoration,
            value: _currentSugars,
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
              value: _currentStrength.toDouble(),
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
              print(_currentName);
              print(_currentSugars);
              print(_currentStrength);
            },
          ),
        ],
      ),
    );
  }
}
