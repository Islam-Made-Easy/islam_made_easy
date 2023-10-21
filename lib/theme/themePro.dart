import 'package:islam_made_easy/views/QnA/qna.dart';

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
        useMaterial3: true,
        brightness: Brightness.light,
        cardColor: kLightSecondaryColor,
        splashFactory: InkRipple.splashFactory,
        primaryColorLight: kLightSecondaryColor,
        primaryColor: Colors.primaries[themeIndex].shade100,
        scaffoldBackgroundColor: kBackgroundLight,
        primarySwatch: Colors.primaries[themeIndex],
        dividerTheme: themeData.dividerTheme.copyWith(color: kDividerLight),
        splashColor: Colors.primaries[themeIndex].withOpacity(.05),
        textTheme: _textTheme(themeData.textTheme, kTextDark, kTextDarker),
        textSelectionTheme: themeData.textSelectionTheme
            .copyWith(cursorColor: Colors.primaries[themeIndex].shade100),
        primaryTextTheme:
            _textTheme(themeData.textTheme, kTextDark, kTextDarker),
        colorScheme: themeData.colorScheme.copyWith(
          brightness: Brightness.light,
          primary: Colors.primaries[themeIndex],
          onPrimary: Colors.primaries[themeIndex],
          secondary: Colors.primaries[themeIndex],
          onSecondary: Colors.primaries[themeIndex],
          error: themeData.colorScheme.error,
          onError: themeData.colorScheme.error,
          background: kBackgroundLight,
          onBackground: kBackgroundLight,
          surface: Colors.primaries[themeIndex],
          onSurface: Colors.primaries[themeIndex],
        ),
        sliderTheme: themeData.sliderTheme.copyWith(
          valueIndicatorTextStyle: TextStyle(color: kLight),
        ),
        dialogTheme: themeData.dialogTheme.copyWith(
          backgroundColor: kLight,
          elevation: 0,
        ),
        chipTheme: themeData.chipTheme.copyWith(
          backgroundColor: kLight.withOpacity(.05),
        ),
        appBarTheme: themeData.appBarTheme.copyWith(
          elevation: 0,
          scrolledUnderElevation: 0,
          color: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        tooltipTheme: themeData.tooltipTheme.copyWith(
          decoration: BoxDecoration(
            color: Colors.primaries[themeIndex].shade50,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          textStyle: TextStyle(color: kLight),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
              fontSize: kSpacingUnit * 1.3,
              fontWeight: FontWeight.w100,
              letterSpacing: 2,
            ),
          ),
        ),
        cardTheme: themeData.cardTheme.copyWith(
          elevation: 0,
          color: kLight,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        navigationRailTheme: themeData.navigationRailTheme.copyWith(
          backgroundColor: Color(0xFFF2F2F2),
          labelType: NavigationRailLabelType.none,
          indicatorColor: Colors.primaries[themeIndex].shade100,
          selectedLabelTextStyle: TextStyle(fontWeight: FontWeight.w900),
        ),
      );
      this._themeDataDark = ThemeData(
        cardColor: kDark,
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColorDark: kDarkPrimaryColor2,
        splashFactory: InkRipple.splashFactory,
        scaffoldBackgroundColor: kBackgroundDark,
        primaryColor: Colors.primaries[themeIndex],
        primarySwatch: Colors.primaries[themeIndex],
        splashColor: Colors.primaries[themeIndex].withOpacity(.05),
        dividerColor: Colors.primaries[themeIndex].withOpacity(.05),
        dividerTheme: themeDataDark.dividerTheme.copyWith(color: kDividerDark),
        textTheme:
            _textTheme(themeDataDark.textTheme, kTextLight, kTextLighter),
        primaryTextTheme:
            _textTheme(themeDataDark.textTheme, kTextLight, kTextLighter),
        textSelectionTheme: themeDataDark.textSelectionTheme.copyWith(
          cursorColor: Colors.primaries[themeIndex],
        ),
        colorScheme: themeDataDark.colorScheme.copyWith(
          brightness: Brightness.dark,
          primary: Colors.primaries[themeIndex],
          onPrimary: Colors.primaries[themeIndex],
          secondary: Colors.primaries[themeIndex],
          onSecondary: Colors.primaries[themeIndex],
          error: themeDataDark.colorScheme.error,
          onError: themeDataDark.colorScheme.error,
          background: kBackgroundDark,
          onBackground: kBackgroundDark,
          surface: Colors.primaries[themeIndex],
          onSurface: Colors.primaries[themeIndex],
        ),
        chipTheme: themeDataDark.chipTheme.copyWith(
          backgroundColor: kLight.withOpacity(.05),
        ),
        dialogTheme: themeDataDark.dialogTheme.copyWith(
          backgroundColor: kDark,
          elevation: 0,
        ),
        sliderTheme: themeDataDark.sliderTheme.copyWith(
          valueIndicatorTextStyle: TextStyle(color: kLight),
        ),
        appBarTheme: themeDataDark.appBarTheme.copyWith(
          elevation: 0,
          scrolledUnderElevation: 0,
          color: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        tooltipTheme: themeDataDark.tooltipTheme.copyWith(
          decoration: BoxDecoration(
            color: Colors.primaries[themeIndex].withOpacity(.4),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          textStyle: TextStyle(color: kLight),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
              fontSize: kSpacingUnit * 1.3,
              fontWeight: FontWeight.w100,
              letterSpacing: 2,
            ),
          ),
        ),
        cardTheme: themeDataDark.cardTheme.copyWith(
          elevation: 0,
          color: kDark,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        navigationRailTheme: themeDataDark.navigationRailTheme.copyWith(
          backgroundColor: kDark,
          labelType: NavigationRailLabelType.none,
          indicatorColor: Colors.primaries[themeIndex].shade500,
          selectedLabelTextStyle: TextStyle(fontWeight: FontWeight.w900),
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

  TextTheme _textTheme(
      TextTheme textTheme, Color displayColor, Color bodyColor) {
    return textTheme
        .copyWith(
          headlineSmall: textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: .5,
            fontSize: 20,
          ),
          titleLarge: textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w500,
            letterSpacing: .5,
            fontSize: 20,
          ),
          bodyLarge: textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
          titleMedium: textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        )
        .apply(
          fontFamily: 'Quicksand',
          displayColor: displayColor,
          bodyColor: bodyColor,
        );
  }

  static bool isDarkMode = false;

  void changeDark(bool isdarkmode) {
    isDarkMode = isdarkmode;
    notifyListeners();
  }
}
