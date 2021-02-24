import 'package:islam_made_easy/utils/sharedP.dart';

class SpUtil {
  static String themeIndex = 'themeIndex';
  static String language = 'language';
  static int getThemeIndex() => appSP.getInt(themeIndex);
  static Future<bool> setThemeIndex(int value) =>
      appSP.setInt(themeIndex, value);
  static String getLanguage() => appSP.getString(language);
  static Future<bool> setLanguage(String value) => appSP.setString(language, value);
}
