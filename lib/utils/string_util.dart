class StringUtil {
  static bool isNullOrEmpty(String string) {
    if (string.isEmpty)
      return true;
    else
      return false;
  }

  static bool isNullOrBlank(String string) {
    if (string.trim().isEmpty)
      return true;
    else
      return false;
  }

  static bool isNotEmpty(String string) {
    if (string.isNotEmpty)
      return true;
    else
      return false;
  }

  static bool isNotBlank(String string) {
    if (string.trim().isNotEmpty)
      return true;
    else
      return false;
  }
}
