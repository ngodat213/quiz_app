import 'package:flutter/material.dart';

class AppColors {
  static const Color titleActive = Color(0xFF000000);
  static const Color body = Color(0xFF3550DC);
  static const Color label = Color(0xFFD4D4D4);
  static const Color placeholder = Color(0xFF888888);
  static const Color line = Color(0xFF333333);
  static const Color inputBackground = Color(0xFF999999);
  static const Color background = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFFCFCFC);
  static const Color primary = Color(0xFFA8715A);
  static const Color secondary = Color(0xFFDD8560);
  static const Color footer = Color(0xFFC4C4C4);
  static const Color border = Color(0xFFDEDEDE);

  static const Color productBlack = Color(0xff0F140D);
  static const Color productOrange = Color(0xffDD8560);
  static const Color productGrey = Color(0xffE1E0DB);

  static LinearGradient myGradient = LinearGradient(
    end: Alignment.bottomRight,
    begin: Alignment.topLeft,
    colors: [
      Color(0xFF3550DC),
      Color(0xFF3550DC),
      Color(0xFF3550DC),
      Color(0xFF27E9F7),
    ],
  );

  static LinearGradient trueAswer = LinearGradient(
    end: Alignment.bottomRight,
    begin: Alignment.topLeft,
    colors: [
      Colors.green,
      Colors.green,
    ],
  );

  static LinearGradient falseAswer = LinearGradient(
    end: Alignment.bottomRight,
    begin: Alignment.topLeft,
    colors: [
      Colors.red,
      Colors.red,
    ],
  );

  static BoxShadow myShadow = BoxShadow(
    color: Color.fromRGBO(51, 51, 51, 0.1),
    offset: Offset(10, 24),
    blurRadius: 54,
  );
}
