import 'package:ez_notes/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:ez_notes/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isSignedIn = Provider.of<bool>(context);

    // return either Home or Authenticate
    if (isSignedIn == false) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
