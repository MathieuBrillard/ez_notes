// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ez_notes/main.dart.txt';
import 'package:ez_notes/shared/delayed_animation.dart.txt';
import 'package:ez_notes/screens/social_page.dart.txt';

// ignore: use_key_in_widget_constructors
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColorTheme,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 60,
              horizontal: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DelayedAnimation(
                  delay: 1000,
                  child: SizedBox(
                    height: 150,
                    child: Image.asset('images/logo_notes.png'),
                  ),
                ),
                DelayedAnimation(
                  delay: 2000,
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.only(
                      top: 50,
                      bottom: 20,
                    ),
                    child: Text(
                      // ignore: prefer_adjacent_string_concatenation
                      'Une superbe application pour prendre ' +
                          'des notes et ne plus rien oublier !',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                DelayedAnimation(
                  delay: 3000,
                  child: Container(
                    width: 170,
                    child: ElevatedButton(
                      child: const Text("Démarrer"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SocialPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: colorTheme,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
