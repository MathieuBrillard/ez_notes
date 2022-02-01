// ignore_for_file: use_key_in_widget_constructors

import 'package:ez_notes/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:ez_notes/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final boolSignInState = Provider.of<bool>(context);

    // return either Home or Authenticate
    if (boolSignInState == false) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
