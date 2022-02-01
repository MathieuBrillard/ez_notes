import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorTheme = Color(0xFFf53152);
const bgColorTheme = Color(0xFF212021);

InputDecoration textInputDecoration = InputDecoration(
  labelStyle: GoogleFonts.outfit(
    color: Colors.grey.shade400,
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: colorTheme),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade400),
  ),
);

ButtonStyle confirmButtonStyle = ElevatedButton.styleFrom(
  shape: StadiumBorder(),
  primary: colorTheme,
  padding: EdgeInsets.symmetric(
    horizontal: 80,
    vertical: 13,
  ),
);
TextStyle confirmButtonTextStyle = GoogleFonts.outfit(
  color: Colors.white,
  fontSize: 15,
  fontWeight: FontWeight.w500,
);

TextStyle errorStyle = GoogleFonts.outfit(
  color: Colors.red,
  fontSize: 14.0,
);
