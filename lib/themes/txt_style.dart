import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/themes/dimen.dart';

class TxtStyle {
  TxtStyle._();

  static TextStyle font20(Color? color) => GoogleFonts.tenorSans(
        color: color ?? Colors.black,
        fontSize: Dimens.TEXT_SIZE_20,
        fontWeight: FontWeight.w700,
      );

  static TextStyle font18(Color? color) => GoogleFonts.ubuntu(
        color: color ?? Colors.black,
        fontSize: Dimens.TEXT_SIZE_18,
        fontWeight: FontWeight.w400,
      );

  static TextStyle font16(Color? color) => GoogleFonts.ubuntu(
        color: color ?? Colors.black,
        fontSize: Dimens.TEXT_SIZE_16,
        fontWeight: FontWeight.w500,
      );

  static TextStyle font15(Color? color) => GoogleFonts.tenorSans(
        color: color ?? Colors.black,
        fontSize: Dimens.TEXT_SIZE_15,
        fontWeight: FontWeight.w400,
      );

  static TextStyle font14(Color? color) => GoogleFonts.tenorSans(
        color: color ?? Colors.black,
        fontSize: Dimens.TEXT_SIZE_14,
        fontWeight: FontWeight.w400,
      );

  static TextStyle font13(Color? color) => GoogleFonts.tenorSans(
        color: color ?? Colors.black,
        fontSize: Dimens.TEXT_SIZE_13,
        fontWeight: FontWeight.w400,
      );

  static TextStyle font12(Color? color) => GoogleFonts.ubuntu(
        color: color ?? Colors.black,
        fontSize: Dimens.TEXT_SIZE_12,
        fontWeight: FontWeight.w400,
      );

  static TextStyle font10(Color? color) => GoogleFonts.tenorSans(
        color: color ?? Colors.black,
        fontSize: Dimens.TEXT_SIZE_10,
        fontWeight: FontWeight.w400,
      );
}
