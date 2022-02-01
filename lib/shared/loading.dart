import 'package:ez_notes/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColorTheme,
      child: Center(
        child: SpinKitPouringHourGlass(color: colorTheme, size: 50.0),
      ),
    );
  }
}
