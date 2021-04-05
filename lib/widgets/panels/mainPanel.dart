import 'dart:io';
import 'dart:math';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grafpix/icons.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/services/daily.dart';
import 'package:islam_made_easy/settings/settings.dart';
import 'package:islam_made_easy/views/succinct.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class MainPanel extends StatefulWidget {
  @override
  _MainPanelState createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  PageController _controller;
  List data;
  var _index;
  int _actualPageNumber = 1;

  // PDFDocument _document;
  var quote;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    random();
    DailyNotification().getQuoteString();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      DailyNotification().init();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void random() {
    setState(
      () {
        _index = Random(_index).nextInt(4000);
      },
    );
  }

  File localFile;
  int _today = HijriCalendar().hMonth;
  int _day = HijriCalendar().hDay;

  // if (_today == 9 && _day == 1) {
  //   _day++;
  // }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
    final size = MediaQuery.of(context).size;
    if (!isDesktop) {
      return PageView(controller: _controller, children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        leading: IconButton(
                          icon: FaIcon(
                              FontAwesomeIcons.bookOpen..matchTextDirection),
                          splashRadius: 20,
                          onPressed: () => Get.to(() => Succinct()),
                        ),
                        elevation: 0,
                        iconTheme: IconThemeData(color: Colors.black),
                        backgroundColor: Colors.transparent,
                        actions: [
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.cog),
                            splashRadius: 20,
                            onPressed: () => Get.to(() => Settings()),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        S.current.salam,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(height: 10),
                      Text(
                        S.current.quizDirection,
                        style: TextStyle(
                            fontWeight: FontWeight.w200, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView(
                    children: [
                      buildCard('Tawheed', S.current.tawheed),
                      buildCard('Prayer', S.current.prayer),
                      buildCard('Fast', S.current.swaum),
                      buildCard('Qur\'an', S.current.quran),
                      buildCard('Charity', S.current.zakkah),
                      buildCard('Hajj', S.current.hajj),
                      buildCard('Marriage', S.current.nikkah),
                      buildCard('History', S.current.history),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Container(
            child: PDF.assets(
              "assets/daily/daily.pdf",
              height: size.height,
              width: size.width,
              placeHolder: Lottie.asset('assets/lottie/loader.json'),
            ),
          ),
        ),
        // AnnotatedRegion(
        //   value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        //   child: Container(
        //     child: Stack(
        //       children: [
        //         circle(),
        //         ListView(
        //           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.only(left: 20.0, top: 20),
        //               child: Row(
        //                 children: <Widget>[
        //                   new Container(
        //                     child: Text("quote.",
        //                         style: Theme.of(context)
        //                             .textTheme
        //                             .headline3
        //                             .copyWith(color: Colors.white)),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               width: 355,
        //               height: 475,
        //               child: new FutureBuilder(
        //                 future: DefaultAssetBundle.of(context)
        //                     .loadString('assets/daily/daily.json'),
        //                 builder: (context, snapshot) {
        //                   quote = json.decode(snapshot.data.toString());
        //                   return new PageView.builder(
        //                     itemBuilder: (BuildContext context, int index) {
        //                       return new PageView(
        //                         children: <Widget>[
        //                           ScrollConfiguration(
        //                             behavior: NoGlow(),
        //                             child: Center(
        //                               child: SingleChildScrollView(
        //                                 child: new Container(
        //                                   child: new Column(
        //                                     mainAxisAlignment:
        //                                         MainAxisAlignment.center,
        //                                     children: <Widget>[
        //                                       new Padding(
        //                                         padding: const EdgeInsets.only(
        //                                             left: 19),
        //                                         child: Text(
        //                                           quote[index]['Quote'],
        //                                           style: Theme.of(context)
        //                                               .textTheme
        //                                               .headline6
        //                                               .copyWith(
        //                                                   fontWeight:
        //                                                       FontWeight.bold,
        //                                                   letterSpacing: 2,
        //                                                   color: Colors.white),
        //                                         ),
        //                                       ),
        //                                       Padding(
        //                                         padding: const EdgeInsets.only(
        //                                             left: 195.0, top: 25),
        //                                         child: Text(
        //                                             "- " +
        //                                                 quote[index]['Author'],
        //                                             style: Theme.of(context)
        //                                                 .textTheme
        //                                                 .subtitle1
        //                                                 .copyWith(
        //                                                     fontWeight:
        //                                                         FontWeight.bold,
        //                                                     color: Colors.white,
        //                                                     fontFamily:
        //                                                         "fontaa")),
        //                                       )
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //                           )
        //                         ],
        //                       );
        //                     },
        //                     physics: NeverScrollableScrollPhysics(),
        //                   );
        //                 },
        //               ),
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceAround,
        //               children: <Widget>[
        //                 Container(
        //                   width: 90,
        //                   height: 50,
        //                   child: new RaisedButton(
        //                     shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(30)),
        //                     elevation: 10,
        //                     color: Colors.yellow.shade700,
        //                     child: new Icon(Icons.panorama_fish_eye,
        //                         color: Colors.black),
        //                     onPressed: () {
        //                       random();
        //                     },
        //                   ),
        //                 ),
        //                 Container(
        //                   width: 90,
        //                   height: 50,
        //                   child: RaisedButton(
        //                     shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(30)),
        //                     elevation: 10,
        //                     color: Colors.pink.shade200,
        //                     child: Icon(
        //                       Icons.share,
        //                       color: Colors.black,
        //                     ),
        //                     onPressed: () {
        //                       Share.share(
        //                           "${this.quote[_index]['Quote']}\n\n - ${this.quote[_index]['Author']}");
        //                     },
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ]);
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Get.theme.primaryColorDark, Get.theme.backgroundColor],
                tileMode: TileMode.repeated,
                begin: locale.languageCode == 'ar'
                    ? Alignment.topRight
                    : Alignment.topLeft,
                end: locale.languageCode == 'ar'
                    ? Alignment.bottomLeft
                    : Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  height: Get.size.height,
                  width: Get.size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Get.theme.primaryColorDark,
                        Get.theme.backgroundColor
                      ],
                      begin: locale.languageCode == 'ar'
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      end: locale.languageCode == 'ar'
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                    ),
                  ),
                ),
                AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    S.current.salam,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      shadows: [
                        Shadow(
                          color: Colors.transparent,
                          blurRadius: 10.0,
                          offset: Offset(3.0, 3.0),
                        ),
                        Shadow(
                          color: Colors.transparent,
                          blurRadius: 10.0,
                          offset: Offset(-2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 100),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Get.theme.primaryColorDark,
                          Get.theme.backgroundColor
                        ],
                        begin: locale.languageCode == 'ar'
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        end: locale.languageCode == 'ar'
                            ? Alignment.bottomLeft
                            : Alignment.bottomRight,
                      ),
                      color: Color(0xFFFAFAFC).withOpacity(0.1),
                      // border: Border.all(color: Color(4278190080)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.current.quizDirection,
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 260.0, left: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Get.theme.primaryColorDark,
                          Get.theme.backgroundColor
                        ],
                        begin: locale.languageCode == 'ar'
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        end: locale.languageCode == 'ar'
                            ? Alignment.bottomRight
                            : Alignment.bottomLeft,
                      ),
                      color: Colors.transparent,
                      // border: Border.all(color: Color(0xFFFAFAFC)),
                      // borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisSpacing: 50,
                          maxCrossAxisExtent: 300,
                          crossAxisSpacing: 50,
                          childAspectRatio: 2.4),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: [
                        buildCard('Tawheed', S.current.tawheed),
                        buildCard('Prayer', S.current.prayer),
                        buildCard('Fast', S.current.swaum),
                        buildCard('Quran', S.current.quran),
                        buildCard('Charity', S.current.zakkah),
                        buildCard('Hajj', S.current.hajj),
                        buildCard('Marriage', S.current.nikkah),
                        buildCard('History', S.current.history),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  Future<bool> hasSupport() async {
    final deviceInfo = DeviceInfoPlugin();
    bool hasSupport = false;
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      hasSupport = int.parse(iosInfo.systemVersion.split('.').first) >= 11;
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      hasSupport = androidInfo.version.sdkInt >= 21;
    }
    return hasSupport;
  }

  Stack circle() {
    return new Stack(
      children: <Widget>[
        Container(),
        new Positioned(
          top: -75.0,
          right: 85.0,
          child: new Container(
            height: 120.0,
            width: 140.0,
            decoration: BoxDecoration(
                gradient: yellowOrangeGradient, shape: BoxShape.circle),
          ),
        ),
        new Positioned(
          right: -7.0,
          top: 620.0,
          child: new Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                gradient: yellowOrangeGradient, shape: BoxShape.circle),
          ),
        ),
        new Positioned(
          right: -75.0,
          top: 245.0,
          child: new Container(
            height: 150.0,
            width: 150.0,
            decoration: BoxDecoration(
                gradient: blackSexyGradient, shape: BoxShape.circle),
          ),
        ),
        new Positioned(
          left: -75.0,
          top: 775.0,
          child: new Container(
            height: 150.0,
            width: 150.0,
            decoration: BoxDecoration(
                gradient: blackBlueGradient, shape: BoxShape.circle),
          ),
        ),
        new Positioned(
          left: 65.0,
          top: 200.0,
          child: new Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                gradient: skyBlueGradient, shape: BoxShape.circle),
          ),
        ),
        new Positioned(
          left: 65.0,
          top: 575.0,
          child: new Container(
            height: 25.0,
            width: 25.0,
            decoration: BoxDecoration(
                gradient: thodaSexyGradient, shape: BoxShape.circle),
          ),
        ),
        new Positioned(
          left: 325.0,
          top: 845.0,
          child: new Container(
            height: 25.0,
            width: 25.0,
            decoration: BoxDecoration(
                gradient: violetSexyGradient, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }

  var blackSexyGradient = new LinearGradient(
      colors: [const Color(0xFF90203F), const Color(0xFF537895)],
      tileMode: TileMode.clamp,
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: [0.0, 1.0]);
  var violetSexyGradient = new LinearGradient(
      colors: [const Color(0xFF52A7EA), const Color(0xFF712E98)],
      tileMode: TileMode.clamp,
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: [0.0, 1.0]);
  var thodaSexyGradient = new LinearGradient(
      colors: [const Color(0xFFF58573), const Color(0xFF5F79F4)],
      tileMode: TileMode.clamp,
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: [0.0, 1.0]);
  var skyBlueGradient = new LinearGradient(
      colors: [const Color(0xFF15EDED), const Color(0xFF029CF5)],
      tileMode: TileMode.clamp,
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: [0.0, 1.0]);
  var blackBlueGradient = new LinearGradient(
      colors: [Colors.blueGrey.shade800, Colors.black87],
      tileMode: TileMode.clamp,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 1.0]);
  var yellowOrangeGradient = new LinearGradient(
    colors: [const Color(0xFFFFFF00), const Color(0xFFFF6600)],
    tileMode: TileMode.clamp,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
  );

  Widget buildCard(String name, String display) {
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
    final colorScheme = Get.theme.colorScheme;
    return WidgetAnimator(
      Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isDesktop ? 4 : 8)),
        child: ListTile(
          contentPadding: EdgeInsets.all(20),
          enableFeedback: true,
          trailing: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colorScheme.secondary),
            child: IconButton(
              icon: FaIcon(
                locale.languageCode == 'ar'
                    ? PixIcon.typcn_chevron_left
                    : PixIcon.typcn_chevron_right,
                color: colorScheme.surface,
              ),
              splashRadius: isDesktop ? 20 : 30, onPressed: () {},
              // onPressed: () => isDesktop
              //     ? Get.dialog(FetchQuestions(name: name))
              //     : Get.to(FetchQuestions(name: name)),
            ),
          ),
          title: Text(
            display,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
