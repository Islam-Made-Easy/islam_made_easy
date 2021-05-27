import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvide with ChangeNotifier {
  static const DEFAULT_THEME_INDEX = 0;
  int _themeIndex = DEFAULT_THEME_INDEX;

  int get themeIndex => _themeIndex;

  ThemeData _themeData = ThemeData(
    primarySwatch: Colors.primaries[DEFAULT_THEME_INDEX],
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.primaries[DEFAULT_THEME_INDEX],
    ),
    fontFamily: 'Amiri',
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: 'Amiri',
      ),
      headline5: TextStyle(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        fontSize: 20,
        fontFamily: 'Amiri',
      ),
      headline6: TextStyle(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        fontSize: 20,
        fontFamily: 'Amiri',
      ),
      subtitle1: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: 'Amiri',
      ),
    ),
  );

  ThemeData get themeData => _themeData;

  SystemUiOverlayStyle _overlayStyle = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.primaries[DEFAULT_THEME_INDEX],
    systemNavigationBarColor: Colors.primaries[DEFAULT_THEME_INDEX],
    statusBarIconBrightness:
        _getReverseBrightness(Colors.primaries[DEFAULT_THEME_INDEX]),
    statusBarBrightness: ThemeData.estimateBrightnessForColor(
        Colors.primaries[DEFAULT_THEME_INDEX]),
    systemNavigationBarIconBrightness:
        _getReverseBrightness(Colors.primaries[DEFAULT_THEME_INDEX]),
  );

  SystemUiOverlayStyle get overlayStyle => _overlayStyle;

  /// [Brightness.dark]，[Brightness.light]，
  static Brightness _getReverseBrightness(materialColor) {
    var reverseBrightness = ThemeData.estimateBrightnessForColor(materialColor);
    return reverseBrightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark;
  }

  void changeTheme(int themeIndex) {
    if (themeIndex >= 0 && themeIndex < Colors.primaries.length) {
      this._themeIndex = themeIndex;
      this._themeData = ThemeData(
        fontFamily: 'Amiri',
        appBarTheme: AppBarTheme(toolbarHeight: 40, elevation: 0),
        primarySwatch: Colors.primaries[themeIndex],
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.primaries[themeIndex],
        ),
      );
      _overlayStyle = SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.primaries[themeIndex],
        systemNavigationBarColor: Colors.primaries[themeIndex],
        statusBarIconBrightness:
            _getReverseBrightness(Colors.primaries[themeIndex]),
        statusBarBrightness:
            ThemeData.estimateBrightnessForColor(Colors.primaries[themeIndex]),
        systemNavigationBarIconBrightness:
            _getReverseBrightness(Colors.primaries[themeIndex]),
      );
      notifyListeners();
    }
  }
}
