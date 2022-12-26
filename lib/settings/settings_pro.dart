import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:islam_made_easy/utils/spUtil.dart';

import '../theme/themePro.dart';

class SettingProvide with ChangeNotifier {
  String? _fontType = 'Roboto';
  double? _fontSize = 16;
  Locale? _locale;

  Locale? get locale => _locale;

  getFontSize(double fontSize) {
    _fontSize = fontSize;
    SpUtil.setFontSize(fontSize);
    notifyListeners();
  }

  getFontFamily(String font) {
    _fontType = font;
    SpUtil.setFont(font);
    notifyListeners();
  }

  String? get fontType => _fontType;

  double? get fontSize => _fontSize;

  void getFullScreen(bool full) async {
    await DesktopWindow.setFullScreen(full);
    SpUtil.setFullScreen(full);
    notifyListeners();
  }

  changeLocale(Locale? locale) {
    _locale = locale;
    notifyListeners();
  }

  void getDark(bool dark) {
    ThemeProvide().changeDark(dark);
    SpUtil.setDarkTheme(dark);
    notifyListeners();
  }
}
