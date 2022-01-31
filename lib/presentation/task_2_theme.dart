import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTheme {
  //1
  static TextTheme textTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
        fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.black),
    headline1: GoogleFonts.openSans(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    headline2: GoogleFonts.openSans(
        fontSize: 21, fontWeight: FontWeight.w700, color: Colors.black),
    headline3: GoogleFonts.openSans(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
    headline6: GoogleFonts.openSans(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
  );

  static ThemeData light() {
    return ThemeData(
        brightness: Brightness.light,
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateColor.resolveWith(
            (states) {
              return Colors.black;
            },
          ),
        ),
        textTheme: textTheme,
        appBarTheme: const AppBarTheme(
            backgroundColor: kPrimaryGreen, centerTitle: true),
        inputDecorationTheme: InputDecorationTheme(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))));
  }
}

//colors
const kPrimaryBackground = Color.fromARGB(255, 247, 247, 247);
const kPrimaryborder = Color.fromARGB(255, 55, 64, 76);
const kPrimaryGreen = Color(0xff156217);
const kPrimaryTexthalf = Color.fromARGB(128, 55, 64, 76);
const kPrimaryButtonBackgrounColor = Color(0xffC4C4C4);
