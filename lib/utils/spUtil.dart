import 'package:islam_made_easy/utils/sharedP.dart';

class SpUtil {
  static String themeIndex = 'themeIndex';
  static String language = 'language';
  static String isDarkMode = 'isDarkMode';
  static String fontFamily = 'fontFamily';
  static String fontSize = 'fontSize';
  static String fullScreen = 'fullScreen';
  static String firstUser = 'firstUser';

  static int? getThemeIndex() => appSP.getInt(themeIndex);

  static bool? getDarkTheme() => appSP.getBool(isDarkMode);

  static Future<bool> setThemeIndex(int value) =>
      appSP.setInt(themeIndex, value);

  static String? getLanguage() => appSP.getString(language);

  static String? getFont() => appSP.getString(fontFamily);

  static double? getFontSize() => appSP.getDouble(fontSize);

  static bool? getFullScreen() => appSP.getBool(fullScreen);

  static bool? getFirstUser() => appSP.getBool(firstUser);

  static Future<bool> setLanguage(String value) =>
      appSP.setString(language, value);

  static Future<bool> setFullScreen(bool value) =>
      appSP.setBool(fullScreen, value);

  static Future<bool> setDarkTheme(bool value) =>
      appSP.setBool(isDarkMode, value);

  static Future<bool> setFirstUser(bool value) =>
      appSP.setBool(firstUser, value);

  static Future<bool> setFont(String value) =>
      appSP.setString(fontFamily, value);

  static Future<bool> setFontSize(double value) =>
      appSP.setDouble(fontSize, value);
}
