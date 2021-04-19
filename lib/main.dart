import 'dart:io';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islam_made_easy/routes/app_route.dart';
import 'package:islam_made_easy/theme/theme.dart';
import 'package:islam_made_easy/theme/themePro.dart';
import 'package:islam_made_easy/utils/quick_util.dart';
import 'package:islam_made_easy/utils/sharedP.dart';
import 'package:islam_made_easy/utils/spUtil.dart';
import 'package:islam_made_easy/utils/string_util.dart';
import 'package:islam_made_easy/views/home.dart';
import 'package:islam_made_easy/views/intro/splash.dart';
import 'package:lottie/lottie.dart';
import 'package:native_updater/native_updater.dart';
import 'package:provide/provide.dart';
import 'package:statusbar_util/statusbar_util.dart';
import 'package:window_size/window_size.dart';

import 'generated/l10n.dart';
import 'locale/localePro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DailyNotification().init();
  // await DailyNotification().getQuoteString();
  StatusbarUtil.setTranslucent();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  // Portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (!kIsWeb) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('Islam Made Easy');
      // setWindowFrame(
      //     Rect.fromCenter(center: Offset.infinite, width: 300, height: 600));
      // setWindowMinSize(Size(1124, 768));
      // setWindowMaxSize(Size.infinite);
    }
  }
  final providers = Providers()
    ..provide(Provider.value(LocaleProvide()))
    ..provide(Provider.value(ThemeProvide()));
  runApp(Phoenix(child: ProviderNode(providers: providers, child: IMEApp())));
}

class IMEApp extends StatefulWidget {
  @override
  _IMEAppState createState() => _IMEAppState();
}

class _IMEAppState extends State<IMEApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _initSp();
  }

  bool isCelebration = false;

  Future _initSp() async {
    var _today = HijriCalendar.now().wkDay;
    await appSP.init();
    int statusCode = 412;
    int themeIndex = SpUtil.getThemeIndex();
    if (themeIndex != null) {
      Provide.value<ThemeProvide>(context).changeTheme(themeIndex);
    }
    String lang = SpUtil.getLanguage();
    if (StringUtil.isNotEmpty(lang)) {
      Provide.value<LocaleProvide>(context).changeLocale(Locale(lang));
    }
    Future.delayed(Duration.zero, () {
      if (statusCode == 412)
        NativeUpdater.displayUpdateAlert(context, forceUpdate: true);
    });

    /// Checks Eid Day to display reminders:
    /// The Messenger of Allāh ﷺ said:
    /// “Verily, Allah has made this day (of Friday) a celebration for the Muslims.
    /// So whoever comes to Friday (prayer), then let him bathe himself,
    /// and if he has any perfume let him put some on, and use the toothstick.”
    if (_today == DateTime.thursday || _today == DateTime.friday) {
      setState(() {
        isCelebration = true;
      });
    }
  }

  Locale localeCallback(locale, supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode)
        return supportedLocale;
    }
    return supportedLocales.first;
  }

// todo: Implement first launch dialog > "وَإِنَّ الْمَلَائِكَةَ لَتَضَعُ أَجْنِحَتَهَا لِطَالِبِ الْعِلْمِ رِضًا بِمَا يَصْنَعُ"

  /// sEARch   
  @override
  Widget build(BuildContext context) {
    final base = ThemeData.light();
    return Provide<LocaleProvide>(
        builder: (BuildContext context, Widget child, localeProvide) {
      return Provide<ThemeProvide>(
          builder: (BuildContext context, Widget child, themeProvide) {
        return GetMaterialApp(
          title: 'Islam Made Easy',
          locale: localeProvide.locale,
          localeResolutionCallback: localeCallback,
          theme: themeProvide.themeData.copyWith(
              textTheme: buildTextTheme(
                  base.textTheme, Color(0xFF333333), Color(0xFF17262A))),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (BuildContext context, Widget widget) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return getErrorWidget(context, errorDetails);
            };
            return widget;
          },
          navigatorObservers: [appRoute],
          routes: appRoute.routes,
          onGenerateRoute: appRoute.generateRoute,
          onGenerateTitle: (context) => S.current.appTitle,
          supportedLocales: S.delegate.supportedLocales,
          home: QuickUtil(child: isCelebration ? SplashView() : Home()),
          debugShowCheckedModeBanner: false,
        );
      });
    });
  }

  Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
    return Center(
      child: AnimatedBackground(
        behaviour: RectanglesBehaviour(),
        vsync: this,
        child: Center(
          child: Lottie.asset(
              kIsWeb ? 'assets/lottie/404.json' : "assets/lottie/loader.json"),
        ),
      ),
    );
  }
}
