import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

enum FormFactorType { Monitor, SmallPhone, LargePhone, Tablet }

class DeviceOS {
  // Syntax sugar, proxy the UniversalPlatform methods so our views can reference a single class
  static bool isIOS = UniversalPlatform.isIOS;
  static bool isAndroid = UniversalPlatform.isAndroid;
  static bool isMacOS = UniversalPlatform.isMacOS;
  static bool isLinux = UniversalPlatform.isLinux;
  static bool isWindows = UniversalPlatform.isWindows;

  // Higher level device class abstractions (more syntax sugar for the views)
  static bool isWeb = kIsWeb;

  /// Windows || MacOS || Linux desktops
  static bool get isDesktop => isWindows || isMacOS || isLinux;

  /// Android || iOS
  static bool get isMobile => isAndroid || isIOS;

  /// Windows, MacOS, Linux desktops || Web
  static bool get isDesktopOrWeb => isDesktop || isWeb;

  /// Windows, MacOS, Linux desktops && Web
  static bool get isDesktopAndWeb => isDesktop && isWeb;

  /// Android, iOS || Web
  static bool get isMobileOrWeb => isMobile || isWeb;
}

class DelayUI {
  int _lastCallMs = 0;

  DelayUI(this.duration);

  final Duration duration;

  void run(VoidCallback action) {
    if (DateTime.now().millisecondsSinceEpoch - _lastCallMs >
        duration.inMilliseconds) {
      action.call();
      _lastCallMs = DateTime.now().millisecondsSinceEpoch;
    }
  }
}
