import 'package:ez_notes/services/auth.dart';
import 'package:ez_notes/shared/constant.dart';
import 'package:ez_notes/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // authentication functions
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // loading screen
  bool loading = false;

  // obscure text button
  bool _obscureText = true;
  IconData _iconPwd = Icons.visibility_off_outlined;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: bgColorTheme,
            appBar: AppBar(
              backgroundColor: colorTheme,
              elevation: 0.0,
              title: Text('Se connecter',
                  style: GoogleFonts.outfit(color: Colors.white)),
              actions: [
                TextButton.icon(
                  icon: Icon(Icons.person, color: bgColorTheme),
                  label: Text('Créer un compte',
                      style: GoogleFonts.outfit(color: bgColorTheme)),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: GoogleFonts.outfit(color: Colors.white),
                      cursorColor: colorTheme,
                      // TODO: Icons on form fields ?
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Votre Email'),
                      validator: (value) =>
                          value!.isEmpty ? 'Spécifiez un email' : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: _obscureText,
                      cursorColor: colorTheme,
                      style: GoogleFonts.outfit(color: Colors.white),
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Mot de passe',
                        suffixIcon: IconButton(
                          icon: Icon(_iconPwd, color: Colors.grey.shade400),
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
                      validator: (value) => value!.length < 8
                          ? 'Entrez un mot de passe de plus de 8 caratères'
                          : null,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: confirmButtonStyle,
                      child: Text('CONFIRMER', style: confirmButtonTextStyle),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error =
                                  'Impossible de se connecter avec ces identifiants.';
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(error, style: errorStyle),
                  ],
                ),
              ),
            ),
          );
  }
}