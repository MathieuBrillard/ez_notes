import 'package:flutter/material.dart';
import 'package:ez_notes/welcome_page.dart';

const colorTheme = Color(0xFFf53152);
const bgColorTheme = Color(0xFF212021);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZ Notes',
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

/* 
Scaffold(
      appBar: AppBar(
        title: const Text('EZ Notes', textAlign: TextAlign.center),
        backgroundColor: colorTheme,
      ),
      backgroundColor: bgColorTheme,
      body: const Center(
        child: DelayedAnimation(
          delay: 1000,
          child: FlutterLogo(
            size: 200,
          ),
        ),
      ),
    );
*/
