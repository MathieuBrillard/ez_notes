import 'package:ez_notes/screens/wrapper.dart';
import 'package:ez_notes/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//TODO: Create an AppbarBuilder (in shared/ folder)
//TODO: Add delayed animation (rebuild the whole design)

void main() {
  InstFirebase.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
      value: AuthService().boolSignInState,
      initialData: false,
      child: MaterialApp(
        title: 'EZ Notes',
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
