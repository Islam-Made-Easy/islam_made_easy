import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grafpix/icons.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/settings/settings.dart';
import 'package:islam_made_easy/views/quiz/quiz_home.dart';
import 'package:islam_made_easy/views/succinct.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';

class MainPanel extends StatefulWidget {
  @override
  _MainPanelState createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final colorScheme = Theme.of(context).colorScheme;
    Locale locale = Localizations.localeOf(context);
    if (!isDesktop) {
      return Container(
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
                        onPressed: () => Get.to(Succinct()),
                      ),
                      elevation: 0,
                      iconTheme: IconThemeData(color: Colors.black),
                      backgroundColor: Colors.transparent,
                      actions: [
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.cog),
                          splashRadius: 20,
                          onPressed: () => Get.to(Settings()),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      S.current.salam,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(height: 10),
                    Text(
                      S.current.quizDirection,
                      style:
                          TextStyle(fontWeight: FontWeight.w200, fontSize: 22),
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
                    buildCard(
                        name: 'Tawheed',
                        colorScheme: colorScheme,
                        display: S.current.tawheed),
                    buildCard(
                        name: 'Prayer',
                        colorScheme: colorScheme,
                        display: S.current.prayer),
                    buildCard(
                        name: 'Fast',
                        colorScheme: colorScheme,
                        display: S.current.swaum),
                    buildCard(
                        name: 'Quran',
                        colorScheme: colorScheme,
                        display: S.current.quran),
                    buildCard(
                        name: 'Charity',
                        colorScheme: colorScheme,
                        display: S.current.zakkah),
                    buildCard(
                        name: 'Hajj',
                        colorScheme: colorScheme,
                        display: S.current.hajj),
                    buildCard(
                        name: 'Marriage',
                        colorScheme: colorScheme,
                        display: S.current.nikkah),
                    buildCard(
                        name: 'History',
                        colorScheme: colorScheme,
                        display: S.current.history),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColorDark,
                  Theme.of(context).backgroundColor,
                ],
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
                        Theme.of(context).primaryColorDark,
                        Theme.of(context).backgroundColor,
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
                          Theme.of(context).primaryColorDark,
                          Theme.of(context).backgroundColor,
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
                          Theme.of(context).primaryColorDark,
                          Theme.of(context).backgroundColor,
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
                        buildCard(
                            name: 'Tawheed',
                            colorScheme: colorScheme,
                            display: S.current.tawheed),
                        buildCard(
                            name: 'Prayer',
                            colorScheme: colorScheme,
                            display: S.current.prayer),
                        buildCard(
                            name: 'Fast',
                            colorScheme: colorScheme,
                            display: S.current.swaum),
                        buildCard(
                            name: 'Quran',
                            colorScheme: colorScheme,
                            display: S.current.quran),
                        buildCard(
                            name: 'Charity',
                            colorScheme: colorScheme,
                            display: S.current.zakkah),
                        buildCard(
                            name: 'Hajj',
                            colorScheme: colorScheme,
                            display: S.current.hajj),
                        buildCard(
                            name: 'Marriage',
                            colorScheme: colorScheme,
                            display: S.current.nikkah),
                        buildCard(
                            name: 'History',
                            colorScheme: colorScheme,
                            display: S.current.history),
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

  Widget buildCard({String name, colorScheme, String display}) {
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
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
                splashRadius: isDesktop ? 20 : 30,
                onPressed: () => isDesktop
                    ? Get.dialog(FetchQuestions(
                        name: name,
                      ))
                    : Get.to(FetchQuestions(name: name))),
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
