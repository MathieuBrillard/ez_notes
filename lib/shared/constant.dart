import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

// app colors
const colorTheme = Color(0xFFf53152);
const bgColorTheme = Color(0xFF212021);
const bgColorTheme2 = Color.fromARGB(76, 255, 255, 255);

// notes colors
// const noteColors = {
//   //'dark':
//   'red': {'l': 0xFFFFCDD2, 'b': 0xFFE57373},
//   'pink': {'l': 0xFFF8BBD0, 'b': 0xFFF06292},
//   'purple': {'l': 0xFFE1BEE7, 'b': 0xFFBA68C8},
//   'deepPurple': {'l': 0xFFD1C4E9, 'b': 0xFF9575CD},
//   'indigo': {'l': 0xFFC5CAE9, 'b': 0xFF7986CB},
//   'blue': {'l': 0xFFBBDEFB, 'b': 0xFF64B5F6},
//   'lightBlue': {'l': 0xFFB3E5FC, 'b': 0xFF4FC3F7},
//   'cyan': {'l': 0xFFB2EBF2, 'b': 0xFF4DD0E1},
//   'teal': {'l': 0xFFB2DFDB, 'b': 0xFF4DB6AC},
//   'green': {'l': 0xFFC8E6C9, 'b': 0xFF81C784},
//   'lightGreen': {'l': 0xFFDCEDC8, 'b': 0xFFAED581},
//   'lime': {'l': 0xFFF0F4C3, 'b': 0xFFDCE775},
//   'yellow': {'l': 0xFFFFF9C4, 'b': 0xFFFFF176},
//   'amber': {'l': 0xFFFFECB3, 'b': 0xFFFFD54F},
//   'orange': {'l': 0xFFFFE0B2, 'b': 0xFFFFB74D},
//   'deepOrange': {'l': 0xFFFFCCBC, 'b': 0xFFFF8A65},
//   'brown': {'l': 0xFFD7CCCB, 'b': 0xFFA1887F},
//   'blueGray': {'l': 0xFFCFD8DC, 'b': 0xFF90A4AE},
// };

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

MarkdownStyleSheet mdStyleSheet = MarkdownStyleSheet(
  a: GoogleFonts.outfit(
    color: Colors.white,
  ),
  p: GoogleFonts.outfit(
    color: Colors.white,
  ),
  code: GoogleFonts.outfit(
    color: Colors.black,
  ),
  h1: GoogleFonts.outfit(
    color: Colors.white,
  ),
  h2: GoogleFonts.outfit(
    color: Colors.white,
  ),
  h3: GoogleFonts.outfit(
    color: Colors.white,
  ),
  h4: GoogleFonts.outfit(
    color: Colors.white,
  ),
  h5: GoogleFonts.outfit(
    color: Colors.white,
  ),
  h6: GoogleFonts.outfit(
    color: Colors.white,
  ),
  em: GoogleFonts.outfit(
    color: Colors.white,
  ),
  strong: GoogleFonts.outfit(
    color: Colors.white,
  ),
  del: GoogleFonts.outfit(
    color: Colors.white,
  ),
  blockquote: GoogleFonts.outfit(
    color: Colors.black,
  ),
  checkbox: GoogleFonts.outfit(
    color: Colors.white,
  ),
  listBullet: GoogleFonts.outfit(
    color: Colors.white,
  ),
  // listBulletPadding: EdgeInsets.only(left: 500),
  tableHead: GoogleFonts.outfit(
    color: Colors.white,
  ),
  tableBody: GoogleFonts.outfit(
    color: Colors.white,
  ),
  tableBorder: TableBorder.all(color: Colors.white),
  // tableColumnWidth: FixedColumnWidth(30),
  textAlign: WrapAlignment.start,
  h1Align: WrapAlignment.start,
  h2Align: WrapAlignment.start,
  h3Align: WrapAlignment.start,
  h4Align: WrapAlignment.start,
  h5Align: WrapAlignment.start,
  h6Align: WrapAlignment.start,
  unorderedListAlign: WrapAlignment.start,
  orderedListAlign: WrapAlignment.start,
  blockquoteAlign: WrapAlignment.start,
  codeblockAlign: WrapAlignment.start,
  textScaleFactor: 1.25,
);
