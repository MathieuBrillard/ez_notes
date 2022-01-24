// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, prefer_adjacent_string_concatenation, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ez_notes/main.dart';
import 'package:ez_notes/delayed_animation.dart';
import 'package:ez_notes/login_page.dart';

// ignore: use_key_in_widget_constructors
class SocialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColorTheme,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: colorTheme,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DelayedAnimation(
                delay: 1000,
                child: Container(
                  height: 150,
                  child: Image.asset('images/logo_notes.png'),
                ),
              ),
              DelayedAnimation(
                delay: 2000,
                child: Container(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 30,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Arrêtez d'oublier dès maintenant !",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            color: colorTheme,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Connectez-vous pour accéder à vos notes depuis" +
                              " n'importe quel appareil !",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 3000,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 350,
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 40,
                  ),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: colorTheme,
                          padding: EdgeInsets.all(13),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(Icons.mail_outline_outlined),
                            SizedBox(width: 10),
                            Text(
                              'EMAIL',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Colors.white,
                          padding: EdgeInsets.all(13),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Image.asset(
                              'images/logo_google.png',
                              height: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'GOOGLE',
                              style: GoogleFonts.outfit(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Color(0xFF576dff),
                          padding: EdgeInsets.all(13),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            FaIcon(FontAwesomeIcons.facebook),
                            SizedBox(width: 10),
                            Text(
                              'FACEBOOK',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
