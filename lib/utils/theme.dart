import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class MyDesktopTheme {
  static ThemeData _baseTheme({required ColorScheme colorScheme}) => ThemeData(
      //fontFamily: 'Proxima Nova Alt',
      //fontFamily: 'Trajan Pro',
      fontFamily: GoogleFonts.montserrat().fontFamily,
      // primaryColor: Colors.primary,
      useMaterial3: true,
      colorScheme: colorScheme,
      dividerColor: Colors.transparent,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        alignLabelWithHint: true,
      ));

  // static final ThemeData lightTheme = _baseTheme(
  //   colorScheme: Colors.lightColorScheme,
  // );

  // static final ThemeData darkTheme = _baseTheme(
  //   colorScheme: Colors.darkColorScheme,
  // );

  static TextStyle textheadingTheme({Color? color}) => TextStyle(
    color: color,
    fontFamily: 'Trajan Pro',
    fontSize: Platform.isAndroid ? 12 : 13,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textheadingAdaptive1214(BuildContext ctx, {Color? color}) {
    Size size = MediaQuery.of(ctx).size;
    return TextStyle(
      color: color,
      fontFamily: 'Trajan Pro',
      fontSize: size.width > 390 ? 14 : (Platform.isAndroid ? 12 : 13),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textheadingAdaptive1416(BuildContext ctx, {Color? color}) {
    Size size = MediaQuery.of(ctx).size;
    return TextStyle(
      color: color,
      fontFamily: 'Trajan Pro',
      fontSize: size.width > 390 ? 16 : 14,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textheading14B({Color? color}) => TextStyle(
    color: color,
    fontFamily: 'Trajan Pro',
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textheading16B({Color? color}) => TextStyle(
    color: color,
    fontFamily: 'Trajan Pro',
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textheading18B({Color? color}) => TextStyle(
    color: color,
    fontFamily: 'Trajan Pro',
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textheading20B({Color? color}) => TextStyle(
    color: color,
    fontFamily: 'Trajan Pro',
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textbodyTheme({FontWeight? fontWeight, Color? color}) => TextStyle(
    color: color,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: Platform.isAndroid ? 12 : 13,
    fontWeight: fontWeight,
  );

  static TextStyle textbody13({FontWeight? fontWeight, Color? color}) => TextStyle(
    color: color,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: 13,
    fontWeight: fontWeight,
  );

  static TextStyle textbody14({FontWeight? fontWeight, Color? color}) => TextStyle(
    color: color,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: 14,
    fontWeight: fontWeight,
  );

  static TextStyle textbody16({FontWeight? fontWeight, Color? color}) => TextStyle(
    color: color,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: 16,
    fontWeight: fontWeight,
  );

  static TextStyle textbody18({FontWeight? fontWeight, Color? color}) => TextStyle(
    color: color,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: 18,
    fontWeight: fontWeight,
  );

  static TextStyle textbody20({FontWeight? fontWeight, Color? color}) => TextStyle(
    color: color,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: 20,
    fontWeight: fontWeight,
  );
}
