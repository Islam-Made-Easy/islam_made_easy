import 'dart:async';

import 'package:animated_background/animated_background.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islam_made_easy/locale/localePro.dart';
import 'package:islam_made_easy/routes/app_route.dart';
import 'package:islam_made_easy/settings/settings_pro.dart';
import 'package:islam_made_easy/theme/themePro.dart';
import 'package:islam_made_easy/utils/logger.dart';
import 'package:islam_made_easy/utils/quick_util.dart';
import 'package:islam_made_easy/utils/sharedP.dart';
import 'package:islam_made_easy/utils/spUtil.dart';
import 'package:islam_made_easy/utils/string_util.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/views/intro/fridayRem.dart';
import 'package:islam_made_easy/widgets/anim/load_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  initLogger(() async {
    setPathUrlStrategy();
    // await FeedbackServices.init();
    if (kIsWeb) {
      const int megabyte = 1000000;
      SystemChannels.skia
          .invokeMethod('Skia.setResourceCacheMaxBytes', 512 * megabyte);
      await Future<void>.delayed(Duration.zero);
    } else if (DeviceOS.isDesktop) {
      await DesktopWindow.setMinWindowSize(const Size(1051.0, 646.0));
      // doWhenWindowReady(() {
      //   final win = appWindow;
      //   const initialSize = Size(600, 450);
      //   win.minSize = initialSize;
      //   win.size = initialSize;
      //   win.alignment = Alignment.center;
      //   win.title = "Islam Made Easy";
      //   win.show();
      // });
    }

    /// Create core models & services
    // FirebaseService firebase = FirebaseFactory.create();
    // AppModel appModel = AppModel(firebase);
    runApp(
      Phoenix(
        child: MultiProvider(
          providers: [
//            ChangeNotifierProvider.value(value: NotificationServices()),
            // Firebase
            // Provider.value(value: firebase),
            // ChangeNotifierProvider.value(value: appModel),
            ChangeNotifierProvider.value(value: ThemeProvide()),
            ChangeNotifierProvider.value(value: SettingProvide()),
            ChangeNotifierProvider.value(value: LocaleProvide()),
          ],
          child: IMEApp(),
        ),
      ),
    );
  });
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
    await appSP.init();
    var _today = HijriCalendar.now().wkDay;
    int _now = DateTime.now().hour;
    bool? dark = SpUtil.getDarkTheme();
    if (dark != null) {
      Provider.of<ThemeProvide>(context, listen: false).getDark(dark);
    }
    double? fontSize = SpUtil.getFontSize();
    if (fontSize != null) {
      Provider.of<SettingProvide>(context, listen: false).getFontSize(fontSize);
    }
    int? themeIndex = SpUtil.getThemeIndex();
    //  Provider.of<NotificationServices>(context, listen: false).init();
    if (themeIndex != null) {
      Provider.of<ThemeProvide>(context, listen: false).changeTheme(themeIndex);
    }
    String font = SpUtil.getFont()!;
    if (StringUtil.isNotEmpty(font)) {
      Provider.of<SettingProvide>(context, listen: false).getFontFamily(font);
    }
    String lang = SpUtil.getLanguage()!;
    if (StringUtil.isNotEmpty(lang)) {
      Provider.of<LocaleProvide>(context, listen: false).changeLocale(Locale(lang));
    }
    if ((_today == DateTime.thursday && _now > 18) ||
        (_today == DateTime.friday && _now < 18)) {
      setState(() {
        isCelebration = true;
      });
    }
  }

  Locale? localeCallback(locale, supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode)
        return supportedLocale;
    }
    return supportedLocales.first;
  }

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
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return getErrorWidget(context, errorDetails);
        };
        return widget!;
      },
      navigatorObservers: [appRoute],
      routes: appRoute.routes,
      onGenerateRoute: appRoute.generateRoute,
      onGenerateTitle: (context) => S.current.appTitle,
      supportedLocales: S.delegate.supportedLocales,
      home: QuickUtil(child: isCelebration ? FridayRem() : Home()),
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
