import 'package:flutter/material.dart';
import 'package:ez_notes/shared/constant.dart';
import 'package:google_fonts/google_fonts.dart';

Color grey = Colors.grey.shade400;

InputDecoration customDeco({
  Color? textColor,
  String? helperText,
  String? border,
  bool? fill,
  Color? fiColor,
}) {
  // Border Builder
  var focBorder = null;
  var enaBorder = null;
  if (border?.toLowerCase() == 'u') {
    focBorder = UnderlineInputBorder(borderSide: BorderSide(color: colorTheme));
    enaBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: grey),
    );
  } else if (border?.toLowerCase() == 'o') {
    focBorder = OutlineInputBorder(borderSide: BorderSide(color: colorTheme));
    enaBorder = OutlineInputBorder(
      borderSide: BorderSide(color: grey),
    );
  } else if (border?.toLowerCase() == 'r') {
    focBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colorTheme),
      borderRadius: BorderRadius.circular(25),
    );
    enaBorder = OutlineInputBorder(
      borderSide: BorderSide(color: grey),
      borderRadius: BorderRadius.circular(25),
    );
  }

  // InputDecoration Builder
  return InputDecoration(
    labelStyle: GoogleFonts.outfit(
      color: textColor ?? grey,
    ),
    focusedBorder: focBorder,
    enabledBorder: enaBorder,
    helperText: helperText,
    helperStyle: GoogleFonts.outfit(
      color: textColor ?? grey,
    ),
    filled: fill,
    fillColor: fiColor,
  );
}
