import 'dart:async';

import 'package:animated_background/animated_background.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islam_made_easy/routes/app_route.dart';
import 'package:islam_made_easy/services/feedback_services.dart';
import 'package:islam_made_easy/theme/themePro.dart';
import 'package:islam_made_easy/utils/device_info.dart';
import 'package:islam_made_easy/utils/quick_util.dart';
import 'package:islam_made_easy/utils/sharedP.dart';
import 'package:islam_made_easy/utils/spUtil.dart';
import 'package:islam_made_easy/utils/string_util.dart';
import 'package:islam_made_easy/views/home.dart';
import 'package:islam_made_easy/views/intro/splash.dart';
import 'package:islam_made_easy/widgets/anim/load_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_size/window_size.dart';

import 'generated/l10n.dart';
import 'locale/localePro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  // Portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await FeedbackServices.init();
  if (kIsWeb) {
    const int megabyte = 1000000;
    SystemChannels.skia.invokeMethod('Skia.setResourceCacheMaxBytes', 512 * megabyte);
    await Future<void>.delayed(Duration.zero);
  } else {
    if (DeviceOS.isDesktop) {
      await DesktopWindow.setMinWindowSize(const Size(1051.0, 646.0));
      setWindowTitle('Islam Made Easy');
    }
  }

  runApp(
    Phoenix(
      child: MultiProvider(
        providers: [
          // ChangeNotifierProvider.value(value: NotificationServices()),
          ChangeNotifierProvider.value(value: ThemeProvide()),
          ChangeNotifierProvider.value(value: LocaleProvide()),
        ],
        child: IMEApp(),
      ),
    ),
  );
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
    bool dark = SpUtil.getDarkTheme();
    if (dark != null) {
      Provider.of<ThemeProvide>(context, listen: false).getDark(dark);
    }
    int themeIndex = SpUtil.getThemeIndex();
    // Provider.of<NotificationServices>(context, listen: false).initialize();
    if (themeIndex != null) {
      Provider.of<ThemeProvide>(context, listen: false).changeTheme(themeIndex);
    }
    String lang = SpUtil.getLanguage();
    if (StringUtil.isNotEmpty(lang)) {
      Provider.of<LocaleProvide>(context, listen: false).changeLocale(Locale(lang));
    }
    int timeNow = DateTime.now().hour;
    if ((_today == DateTime.thursday && timeNow > 18) ||
        (_today == DateTime.friday && timeNow < 18)) {
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
// TODO: Add floating feedback requester for web

  /// sEARch   
  @override
  Widget build(BuildContext context) {
    final localeProvide = Provider.of<LocaleProvide>(context);
    final themeProvide = Provider.of<ThemeProvide>(context);
    return GetMaterialApp(
      title: 'Islam Made Easy',
      locale: localeProvide.locale,
      localeResolutionCallback: localeCallback,
      theme: themeProvide.themeData,
      darkTheme: themeProvide.themeDataDark,
      themeMode: ThemeProvide.isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
  }

  Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
    return Center(
      child: AnimatedBackground(
        behaviour: RectanglesBehaviour(),
        vsync: this,
        child: LoadingIndicator(),
      ),
    );
  }
}
