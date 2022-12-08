import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:islam_made_easy/utils/spUtil.dart';

class SettingProvide with ChangeNotifier {
  String? _fontType = 'Roboto';
  double? _fontSize = 16;

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
}
