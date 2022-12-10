import 'package:auto_size_text/auto_size_text.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/views/quiz/quiz_home.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';
import 'package:provider/provider.dart';

import '../../settings/settings_pro.dart';

class MainPanel extends StatefulWidget {
  @override
  _MainPanelState createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    final size = context.mediaQuery.size;
    final appTheme = theme.textTheme.button!.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: isDesktop || context.isTablet ? 30 : 22);
    final selectTheme = theme.textTheme.caption!.copyWith(
      fontWeight: FontWeight.w100,
      fontSize: 22,
      letterSpacing: isDesktop || context.isTablet ? 2 : null,
      fontFamily: ar ? 'Amiri' : 'Roboto',
    );
    if (DeviceOS.isDesktopOrWeb && isDesktop ||
        (context.isTablet && DeviceOS.isMobile)) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.width * .02),
                child: Text(
                  S.current.salam,
                  style: appTheme.copyWith(fontFamily: 'Quicksand'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 30, horizontal: size.width * .02),
                child: Text(S.current.quizDirection, style: selectTheme),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .02, vertical: size.height * .07),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisSpacing: size.width * .05,
                      maxCrossAxisExtent: size.height * .4,
                      crossAxisSpacing: size.height * .09,
                      childAspectRatio: 2.4),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    buildCard(S.current.aqeedah),
                    buildCard(S.current.worship),
                    buildCard(S.current.hisLife),
                    buildCard(S.current.quran),
                    buildCard(S.current.stories),
                    buildCard(S.current.companions),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.isTablet ? 30 : 20,
                  vertical: context.isTablet ? 20 : 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(S.current.salam,
                      style: appTheme.copyWith(fontFamily: 'Quicksand')),
                  SizedBox(height: 10),
                  Text(S.current.quizDirection, style: selectTheme),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.isTablet ? 30 : 20,
                  vertical: context.isTablet ? 20 : 10),
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                children: [
                  buildCard(S.current.aqeedah),
                  buildCard(S.current.worship),
                  buildCard(S.current.hisLife),
                  buildCard(S.current.quran),
                  buildCard(S.current.stories),
                  buildCard(S.current.companions),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget buildCard(String title) {
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
    final theme = Theme.of(context);
    final ar = locale.languageCode == 'ar';
    final size = context.mediaQuery.size;
    return WidgetAnimator(
      AnimContainer(
        alignment: Alignment.center,
        child: Card(
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Positioned(
                bottom: isDesktop ? size.height * .097 : size.height * .1,
                right: ar
                    ? isDesktop
                        ? size.width * .15
                        : size.width * .55
                    : 0,
                left: ar
                    ? 0
                    : isDesktop
                        ? size.width * .15
                        : size.width * .55,
                child: Container(
                  height: isDesktop ? size.height * .9 : size.height * .2,
                  decoration: BoxDecoration(
                    color: theme.splashColor.withOpacity(.07),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight:
                            ar ? Radius.elliptical(50, 110) : Radius.zero,
                        bottomLeft:
                            ar ? Radius.zero : Radius.elliptical(50, 110)),
                  ),
                ),
              ),
              Positioned(
                top: -size.height * .08,
                left: ar
                    ? isDesktop
                        ? size.width * .05
                        : size.width * .43
                    : 0,
                right: ar
                    ? 0
                    : isDesktop
                        ? size.width * .05
                        : size.width * .43,
                child: Container(
                  height: size.height * .165,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomLeft:
                            ar ? Radius.elliptical(50, 120) : Radius.zero,
                        bottomRight:
                            ar ? Radius.zero : Radius.elliptical(50, 120)),
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primaryContainer,
                        theme.colorScheme.secondary,
                      ],
                      tileMode: TileMode.mirror,
                      begin: !ar ? Alignment.topLeft : Alignment.topRight,
                      end: !ar ? Alignment.bottomRight : Alignment.bottomLeft,
                      stops: [.0, 1.0],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: isDesktop ? size.height * .098 : -size.height * .065,
                left: ar
                    ? isDesktop
                        ? size.width * .05
                        : size.width * .35
                    : 0,
                right: ar
                    ? 0
                    : isDesktop
                        ? size.width * .05
                        : size.width * .35,
                child: Container(
                  height: size.height * .175,
                  decoration: BoxDecoration(
                    color: theme.splashColor.withOpacity(.07),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomLeft:
                            ar ? Radius.elliptical(50, 110) : Radius.zero,
                        bottomRight:
                            ar ? Radius.zero : Radius.elliptical(50, 121)),
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(20),
                enableFeedback: true,
                trailing: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: theme.colorScheme.secondary),
                  child: IconButton(
                    icon: FaIcon(
                      ar ? Icons.chevron_left : Icons.chevron_right,
                      color: Colors.white,
                    ),
                    splashRadius: isDesktop ? 20 : 30,
                    onPressed: () {
                      setState(() async {
                        Provider.of<SettingProvide>(context, listen: false)
                            .getFullScreen(true);
                        await DesktopWindow.setFullScreen(true);
                        Get.to(() => QuizHome());
                      });
                    },
                  ),
                ),
                title: AutoSizeText(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: context.isTablet
                          ? 22
                          : context.isPhone
                              ? 17
                              : null,
                      fontFamily: ar ? 'Amiri' : 'Quicksand'),
                ),
                tileColor: theme.hoverColor,
              ),
              Positioned(
                top: isDesktop ? size.height * .098 : size.height * .1,
                left: ar
                    ? 0
                    : isDesktop
                        ? size.width * .16
                        : size.width * .55,
                right: ar
                    ? isDesktop
                        ? size.width * .16
                        : size.width * .55
                    : 0,
                child: Container(
                  height: size.height * .175,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: ar ? Radius.zero : Radius.elliptical(50, 20),
                          topRight:
                              ar ? Radius.elliptical(50, 20) : Radius.zero),
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.secondary,
                          theme.colorScheme.primaryContainer,
                        ],
                        tileMode: TileMode.mirror,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [.0, 1.0],
                      ),
                      shape: BoxShape.rectangle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
