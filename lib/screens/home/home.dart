import 'package:ez_notes/shared/constant.dart';
import 'package:ez_notes/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColorTheme,
      appBar: AppBar(
        title: const Text('EZ Notes'),
        backgroundColor: colorTheme,
        elevation: 0.0,
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.person_off,
              color: bgColorTheme,
            ),
            label: const Text(
              'Déconnexion',
              style: TextStyle(
                color: bgColorTheme,
              ),
            ),
            onPressed: () {
              _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
