import 'package:ez_notes/services/auth.dart';
import 'package:ez_notes/shared/constant.dart';
import 'package:ez_notes/shared/delayed_animation.dart';
import 'package:ez_notes/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ez_notes/services/user_secure_storage.dart';

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
  String error = '';

  // credentials save
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late bool saveEmail = false;
  late bool savePwd = false;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    _email.text = await UserSecureStorage.getUsername() ?? '';
    _password.text = await UserSecureStorage.getPassword() ?? '';

    setState(() {
      saveEmail = (_email.text != '') ? true : false;
      savePwd = (_password.text != '') ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: bgColorTheme,
            appBar: AppBar(
              backgroundColor: colorTheme,
              elevation: 0.0,
              title: Center(
                child: Text('Se connecter',
                    style: GoogleFonts.outfit(color: Colors.white)),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.person_add_alt_1, color: bgColorTheme),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        DelayedAnimation(
                          delay: 500,
                          child: SizedBox(
                            height: 150,
                            child: Image.asset('assets/logo_notes.png'),
                          ),
                        ),
                        SizedBox(height: 50.0),
                        DelayedAnimation(
                          delay: 1000,
                          child: SizedBox(
                            width: 500,
                            child: TextFormField(
                              autofocus: true,
                              controller: _email,
                              style: GoogleFonts.outfit(color: Colors.white),
                              cursorColor: colorTheme,
                              decoration: textInputDecoration.copyWith(
                                  labelText: 'Votre Email'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Spécifiez un email' : null,
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        DelayedAnimation(
                          delay: 1500,
                          child: SizedBox(
                            width: 500,
                            child: TextFormField(
                              obscureText: _obscureText,
                              controller: _password,
                              cursorColor: colorTheme,
                              style: GoogleFonts.outfit(color: Colors.white),
                              decoration: textInputDecoration.copyWith(
                                labelText: 'Mot de passe',
                                suffixIcon: IconButton(
                                  icon: Icon(_iconPwd,
                                      color: Colors.grey.shade400),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                      if (_obscureText == true) {
                                        _iconPwd =
                                            Icons.visibility_off_outlined;
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
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 500,
                          child: CheckboxListTile(
                            title: Text(
                              'Se souvenir de mon email',
                              style: GoogleFonts.outfit(color: Colors.white),
                            ),
                            tileColor: bgColorTheme,
                            checkColor: colorTheme,
                            activeColor: bgColorTheme,
                            value: saveEmail,
                            onChanged: (value) {
                              setState(() {
                                saveEmail = !saveEmail;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 500,
                          child: CheckboxListTile(
                            title: Text(
                              'Se souvenir de mon mot de passe',
                              style: GoogleFonts.outfit(color: Colors.white),
                            ),
                            tileColor: bgColorTheme,
                            checkColor: colorTheme,
                            activeColor: bgColorTheme,
                            value: savePwd,
                            onChanged: (value) {
                              setState(() {
                                savePwd = !savePwd;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        DelayedAnimation(
                          delay: 2000,
                          child: ElevatedButton(
                            style: confirmButtonStyle,
                            child: Text('CONFIRMER',
                                style: confirmButtonTextStyle),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                //TODO: handle errors correctly (https://stackoverflow.com/questions/56113778/how-to-handle-firebase-auth-exceptions-on-flutter)
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        _email.text, _password.text);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error =
                                        'Impossible de se connecter avec ces identifiants.';
                                  });
                                } else {
                                  if (saveEmail) {
                                    await UserSecureStorage.setUsername(
                                        _email.text);
                                  } else {
                                    await UserSecureStorage.deleteUsername();
                                  }
                                  if (savePwd) {
                                    await UserSecureStorage.setPassword(
                                        _password.text);
                                  } else {
                                    await UserSecureStorage.deletePassword();
                                  }
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(error, style: errorStyle),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
