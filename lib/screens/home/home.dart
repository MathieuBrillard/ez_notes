import 'package:ez_notes/models/brew.dart';
import 'package:ez_notes/screens/home/brew_list.dart';
import 'package:ez_notes/screens/home/settings_form.dart';
import 'package:ez_notes/shared/constant.dart';
import 'package:ez_notes/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ez_notes/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        backgroundColor: bgColorTheme,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: bgColorTheme,
        appBar: AppBar(
          title: const Text('EZ Notes'),
          backgroundColor: colorTheme,
          elevation: 0.0,
          actions: [
            TextButton.icon(
              icon: Icon(Icons.person_off, color: bgColorTheme),
              label: const Text('Déconnexion',
                  style: TextStyle(color: bgColorTheme)),
              onPressed: () {
                _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.settings, color: bgColorTheme),
              label: const Text('Paramètres',
                  style: TextStyle(color: bgColorTheme)),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
