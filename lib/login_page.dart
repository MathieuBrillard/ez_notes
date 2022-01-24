// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, prefer_adjacent_string_concatenation, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ez_notes/main.dart';
import 'package:ez_notes/delayed_animation.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: colorTheme,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: bgColorTheme,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DelayedAnimation(
                      delay: 1000,
                      child: Text(
                        "Connectez votre addresse email",
                        style: GoogleFonts.outfit(
                          color: colorTheme,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 22),
                    DelayedAnimation(
                      delay: 2000,
                      child: Text(
                        "Il est recommandé de connecter votre adresse email " +
                            "car cela permettra de sauvegarder vos données, et de " +
                            "les retrouver sur vos différents appareils.",
                        style: GoogleFonts.outfit(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
              LoginForm(),
              SizedBox(height: 125),
              DelayedAnimation(
                delay: 4000,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: colorTheme,
                    padding: EdgeInsets.symmetric(
                      horizontal: 125,
                      vertical: 13,
                    ),
                  ),
                  child: Text(
                    'CONFIRMER',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _obscureText = true;
  var _iconPwd = Icons.visibility_outlined;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: [
          DelayedAnimation(
            delay: 3000,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400,
              ),
              child: TextField(
                style: GoogleFonts.outfit(
                  color: Colors.white,
                ),
                cursorColor: colorTheme,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorTheme),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  labelText: 'Votre Email',
                  labelStyle: GoogleFonts.outfit(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          DelayedAnimation(
            delay: 3000,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400,
              ),
              child: TextField(
                style: GoogleFonts.outfit(
                  color: Colors.white,
                ),
                obscureText: _obscureText,
                cursorColor: colorTheme,
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.outfit(
                    color: Colors.grey.shade400,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorTheme),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _iconPwd,
                      color: Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                        if (_obscureText == true) {
                          _iconPwd = Icons.visibility_off_outlined;
                        } else {
                          _iconPwd = Icons.visibility_outlined;
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
