import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kSpacingUnit = 10;
const kLightSecondaryColor = Color(0xfff4f6f9);
const kDarkSecondaryColor = Color(0xFF272042);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kDarkPrimaryColor = Color(0xff2934BE);
const kDarkPrimaryColor2 = Color(0xff0e1621);
const kBackgroundLight = Color(0xfff0eeef);
const kBackgroundDark = Color(0xFF11151E);
const kDividerLight = Color(0xFFFFFFFF);
const kDividerDark = Color(0xFF444444);
const kAccentColor = Color(0x95AC25FF);
const kTextLighter = Color(0xFFFBFBFB);
const kTextDarker = Color(0xFF17262A);
const kTextDark = Color(0xFF333333);
const kTextLight = Color(0xFFEEEEEE);
const kDarkColor = Color(0xFF202A43);
const kIconLight = Color(0xFFFBFBFB);
const kIconDark = Color(0xFF666666);
const kGreen = Color(0xFFBCFF00);
const kGreenLight = Color(0xFFD6FC51);
const kColorG = Color(0xffffe598);
const kColor = Color(0xff0f1f27);
const kLight = Color(0xFFFDFDFD);
const kDark = Color(0xFF151D2A);
const kGreyColor = Color(0xffBBC3D7);

class ThemeProvide with ChangeNotifier {
  // To make the app standard start with index 5
  static const DEFAULT_THEME_INDEX = 1;
  int _themeIndex = DEFAULT_THEME_INDEX;

  int get themeIndex => _themeIndex;
  ThemeData _themeData = ThemeData(
    primarySwatch: Colors.primaries[DEFAULT_THEME_INDEX],
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.primaries[DEFAULT_THEME_INDEX],
    ),
  );
  ThemeData _themeDataDark = ThemeData(
    primarySwatch: Colors.primaries[DEFAULT_THEME_INDEX],
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.primaries[DEFAULT_THEME_INDEX],
    ),
  );

  ThemeData get themeData => _themeData;

  ThemeData get themeDataDark => _themeDataDark;

  ///  Status bar style on Android/iOS
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
        splashFactory: InkRipple.splashFactory,
        appBarTheme: AppBarTheme(elevation: 0),
        scaffoldBackgroundColor: kBackgroundLight,
        backgroundColor: kBackgroundLight,
        primarySwatch: Colors.primaries[themeIndex],
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: Colors.primaries[themeIndex].withOpacity(.4),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          textStyle: TextStyle(color: Colors.white, fontFamily: 'Quicksand'),
        ),
        splashColor: Colors.primaries[themeIndex].withOpacity(.05),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            fontFamily: 'Amiri',
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: .5,
            fontSize: 20,
            fontFamily: 'Amiri',
          ),
          headline6: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: .5,
            fontSize: 20,
            fontFamily: 'Amiri',
          ),
          subtitle1: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            fontFamily: 'Amiri',
          ),
        ),
        cardColor: kLightSecondaryColor,
        cardTheme: CardTheme(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        textButtonTheme: TextButtonThemeData(
            style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    fontSize: kSpacingUnit * 1.3,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 2))),
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: Colors.primaries[themeIndex]),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: Color(0xFFF2F2F2),
          labelType: NavigationRailLabelType.none,
          selectedLabelTextStyle: TextStyle(fontWeight: FontWeight.w900),
        ),
      );
      this._themeDataDark = ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Amiri',
          splashFactory: InkRipple.splashFactory,
          appBarTheme: AppBarTheme(elevation: 0),
          accentColor: Colors.primaries[themeIndex],
          tooltipTheme: TooltipThemeData(
            decoration: BoxDecoration(
              color: Colors.primaries[themeIndex].withOpacity(.4),
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            textStyle: TextStyle(color: Colors.white),
          ),
          splashColor: Colors.primaries[themeIndex].withOpacity(.05),
          // colorScheme: ColorScheme(
          //     brightness: Brightness.dark,
          //     primary: Colors.primaries[themeIndex],
          //     onPrimary: Colors.primaries[themeIndex],
          //     secondary: Colors.primaries[themeIndex],
          //     onSecondary: Colors.primaries[themeIndex],
          //     error: themeData.errorColor,
          //     onError: themeData.errorColor,
          //     background: kBackgroundDark,
          //     onBackground: kBackgroundDark,
          //     surface: Colors.primaries[themeIndex],
          //     onSurface: Colors.primaries[themeIndex]),
          dialogTheme: DialogTheme(backgroundColor: kDark),
          primaryColor: Colors.primaries[themeIndex],
          primarySwatch: Colors.primaries[themeIndex],
          dividerTheme: DividerThemeData(color: kDividerDark),
          textButtonTheme: TextButtonThemeData(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      fontSize: kSpacingUnit * 1.3,
                      fontWeight: FontWeight.w100,
                      letterSpacing: 2))),
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
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: Colors.primaries[themeIndex]),
          cardColor: kDark,
          cardTheme: CardTheme(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          primaryColorDark: kDarkPrimaryColor2,
          scaffoldBackgroundColor: kBackgroundDark,
          backgroundColor: kDarkSecondaryColor,
          dividerColor: Colors.primaries[themeIndex].withOpacity(.05),
          navigationRailTheme: NavigationRailThemeData(
            backgroundColor: kDark,
            labelType: NavigationRailLabelType.none,
            selectedLabelTextStyle: TextStyle(fontWeight: FontWeight.w900),
          ));
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

  static bool isDarkMode = false;

  void changeDark(bool isdarkmode) {
    isDarkMode = isdarkmode;
    notifyListeners();
  }
}
