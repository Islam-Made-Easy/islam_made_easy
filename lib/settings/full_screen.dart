import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:islam_made_easy/utils/spUtil.dart';

class AppFullScreen extends ChangeNotifier {
  void getFullScreen(bool full) async {
    await DesktopWindow.setFullScreen(full);
    SpUtil.setFullScreen(full);
    notifyListeners();
  }
}
