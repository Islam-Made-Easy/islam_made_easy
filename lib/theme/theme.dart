import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

const kDark = Color(0xFF333333);
const kLight = Color(0xFFFDFDFD);
//001e36
//0xfff5f1e5
//0xff001e36
const kBackgroundLight = Color(0xFFF2F3F7);
const kBackgroundDark = Color(0xFF2A2A2A);

const kIconDark = Color(0xFF666666);
const kIconLight = Color(0xFFFBFBFB);

const kDividerDark = Color(0xFF444444);
const kDividerLight = Color(0xFFFFFFFF);

const kTextDark = Color(0xFF333333);
const kTextDarker = Color(0xFF17262A);

const kTextLight = Color(0xFFEEEEEE);
const kTextLighter = Color(0xFFFBFBFB);
// Sentinel value for the system text scale factor option.
const double systemTextScaleFactorOption = -1;
double height =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
double width =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
RoundedRectangleBorder kAppBarShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(Platform.isLinux ? 2 : 32),
    bottomRight: Radius.circular(Platform.isLinux ? 2 : 32),
  ),
);

TextTheme buildTextTheme(TextTheme base, Color displayColor, Color bodyColor) {
  return base
      .copyWith(
    headline5: base.headline5.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      fontSize: 20,
    ),
    headline6: base.headline6.copyWith(
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      fontSize: 20,
    ),
    bodyText1: base.bodyText1.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),
    subtitle1: base.bodyText1.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),
  )
      .apply(
    fontFamily: 'Amiri',
    displayColor: displayColor,
    bodyColor: bodyColor,
  );
}
