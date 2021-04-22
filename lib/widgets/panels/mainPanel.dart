import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grafpix/icons.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/settings/settings.dart';
import 'package:islam_made_easy/views/succinct.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';
import 'package:islam_made_easy/widgets/anim/fade_slide.dart';

class MainPanel extends StatefulWidget {
  @override
  _MainPanelState createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> with TickerProviderStateMixin {
  PageController _controller;
  List data;
  AnimationController _animController;
  var quote;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  // int _today = HijriCalendar().hMonth;
  // int _day = HijriCalendar().hDay;

  // if (_today == 9 && _day == 1) {
  //   _day++;
  // }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
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
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Get.theme.primaryColorDark,
                      //     Get.theme.backgroundColor
                      //   ],
                      //   begin: locale.languageCode == 'ar'
                      //       ? Alignment.topRight
                      //       : Alignment.topLeft,
                      //   end: locale.languageCode == 'ar'
                      //       ? Alignment.bottomRight
                      //       : Alignment.bottomLeft,
                      // ),
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

  Widget buildCard(String name, String display) {
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
    final colorScheme = Get.theme.colorScheme;
    final ar = locale.languageCode == 'ar';
    return WidgetAnimator(
      FadingSlidingWidget(
        animationController: _animController,
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          alignment: Alignment.center,
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isDesktop ? 4 : 8)),
            child: Stack(
              children: [
                Positioned(
                  bottom: 70.0,
                  right: ar ? 200 : 0,
                  left: ar ? 0 : 200,
                  child: Container(
                    height: 120.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).splashColor.withOpacity(0.03),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomRight:
                              ar ? Radius.elliptical(50, 110) : Radius.zero,
                          bottomLeft: ar
                              ? Radius.zero
                              : Radius.elliptical(50, 110)),
                    ),
                  ),
                ),
                Positioned(
                  top: -50.0,
                  left: ar ? 160 : 0,
                  right: ar ? 0 : 160,
                  child: Container(
                    height: 120.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomLeft:
                              ar ? Radius.elliptical(50, 120) : Radius.zero,
                          bottomRight: ar
                              ? Radius.zero
                              : Radius.elliptical(50, 120)),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).accentColor,
                          Theme.of(context).backgroundColor
                        ],
                        tileMode: TileMode.mirror,
                        begin: !ar ? Alignment.topLeft : Alignment.topRight,
                        end: !ar
                            ? Alignment.bottomRight
                            : Alignment.bottomLeft,
                        stops: [0.0, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -40.0,
                  left: ar ? 120 : 0,
                  right: ar ? 0 : 120,
                  child: Container(
                    height: 120.0,
                    width: 170.0,
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).splashColor.withOpacity(0.04),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomLeft:
                              ar ? Radius.elliptical(50, 110) : Radius.zero,
                          bottomRight: ar
                              ? Radius.zero
                              : Radius.elliptical(50, 121)),
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(20),
                  enableFeedback: true,
                  trailing: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: colorScheme.secondary),
                    child: IconButton(
                      icon: FaIcon(
                        ar
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
                    style: TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                ),
                Positioned(
                  top: 75.0,
                  left: ar ? 0 : 200,
                  right: ar ? 200 : 0,
                  child: Container(
                    height: 120.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: ar
                                ? Radius.zero
                                : Radius.elliptical(50, 20),
                            topRight: ar
                                ? Radius.elliptical(50, 20)
                                : Radius.zero),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).accentColor,
                            Theme.of(context).backgroundColor
                          ],
                          tileMode: TileMode.mirror,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                        ),
                        shape: BoxShape.rectangle),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
