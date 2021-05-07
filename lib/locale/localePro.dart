import 'package:flutter/widgets.dart';
import 'package:islam_made_easy/theme/theme.dart';

enum CustomTextDirection { localeBased, ltr, rtl }

// See http://en.wikipedia.org/wiki/Right-to-left
const List<String> rtlLanguages = <String>[
  'ar', // Arabic
  'fa', // Farsi
  'he', // Hebrew
  'ps', // Pashto
  'ur', // Urdu
];

class LocaleProvide with ChangeNotifier {
  final CustomTextDirection customTextDirection;
  final double _textScaleFactor;
  Locale _locale;

  LocaleProvide({this.customTextDirection, double textScaleFactor})
      : _textScaleFactor = textScaleFactor;

  Locale get locale => _locale;

  changeLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  // We use a sentinel value to indicate the system text scale option. By
  // default, return the actual text scale factor, otherwise return the
  // sentinel value.
  double textScaleFactor(BuildContext context, {bool useSentinel = false}) {
    if (_textScaleFactor == systemTextScaleFactorOption) {
      return useSentinel
          ? systemTextScaleFactorOption
          : MediaQuery.of(context).textScaleFactor;
    } else {
      return _textScaleFactor;
    }
  }

  /// Returns a text direction based on the [CustomTextDirection] setting.
  /// If it is based on locale and the locale cannot be determined, returns
  /// null.
  TextDirection resolvedTextDirection() {
    switch (customTextDirection) {
      case CustomTextDirection.localeBased:
        final language = locale?.languageCode?.toLowerCase();
        if (language == null) return null;
        return rtlLanguages.contains(language)
            ? TextDirection.rtl
            : TextDirection.ltr;
      case CustomTextDirection.rtl:
        return TextDirection.rtl;
      default:
        return TextDirection.ltr;
    }
  }

  LocaleProvide copyWith(
      {double textScaleFactor, CustomTextDirection customTextDirection}) {
    return LocaleProvide(
      textScaleFactor: textScaleFactor ?? _textScaleFactor,
      customTextDirection: customTextDirection ?? this.customTextDirection,
    );
  }

}

