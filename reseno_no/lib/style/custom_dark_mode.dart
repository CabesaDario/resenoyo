import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData mainTheme(bool isDarkTheme, BuildContext context) {
    if (isDarkTheme) {
      return ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.black,
        backgroundColor: Colors.black,
        indicatorColor: Color(0xff0E1D36),
        buttonColor: Color(0xff3B3B3B),
        hintColor: Colors.teal[600],
        highlightColor: Color(0xff372901),
        hoverColor: Color(0xff3A3A3B),
        focusColor: Color(0xff0B2512),
        disabledColor: Colors.grey,
        cardColor: Color(0xFF151515),
        canvasColor: Colors.white10,
        brightness: Brightness.dark,
        selectedRowColor: Colors.black,
      );
    } else {
      return themeOfLight();
    }
  }

  static ThemeData themeOfLight() {
    return ThemeData(
      // brightness: Brightness.dark,
      appBarTheme: AppBarTheme(backgroundColor: Colors.teal),
      primarySwatch: Colors.deepPurple,
      accentColor: Colors.orange,
      selectedRowColor: Colors.white,
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.orange),
      // fontFamily: 'SourceSansPro',
      textTheme: TextTheme(
        headline3: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 45.0,
          // fontWeight: FontWeight.w400,
          color: Colors.orange,
        ),
        button: TextStyle(
          // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
          fontFamily: 'OpenSans',
        ),
        caption: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: Colors.deepPurple[300],
        ),
        headline1: TextStyle(fontFamily: 'Quicksand'),
        headline2: TextStyle(fontFamily: 'Quicksand'),
        headline4: TextStyle(fontFamily: 'Quicksand'),
        headline5: TextStyle(fontFamily: 'NotoSans'),
        headline6: TextStyle(fontFamily: 'NotoSans'),
        subtitle1: TextStyle(fontFamily: 'NotoSans'),
        bodyText1: TextStyle(fontFamily: 'NotoSans'),
        bodyText2: TextStyle(fontFamily: 'NotoSans'),
        subtitle2: TextStyle(fontFamily: 'NotoSans'),
        overline: TextStyle(fontFamily: 'NotoSans'),
      ),
    );
  }
}
