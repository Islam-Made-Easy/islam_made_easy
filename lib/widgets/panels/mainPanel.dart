import 'package:auto_size_text/auto_size_text.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/views/quiz/quiz_home.dart';
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
    final size = MediaQuery.of(context).size;
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
                      style: appTheme.copyWith(
                          fontFamily: ar ? 'Amiri' : 'Quicksand')),
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
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return WidgetAnimator(
      AnimContainer(
        alignment: Alignment.center,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/design.png'),
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor,
                    BlendMode.modulate,
                  ),
                ),
              ),
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.only(left: 50, right: 20, top: 15, bottom: 20),
              trailing: IconButton(
                icon: FaIcon(Icons.chevron_right),
                splashRadius: 10,
                onPressed: () async {
                  await DesktopWindow.setFullScreen(true);
                  Provider.of<SettingProvide>(context, listen: false)
                      .getFullScreen(true);
                  Get.to(() => QuizHome());
                },
              ),
              title: AutoSizeText(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.isTablet
                      ? 15
                      : context.isPhone
                          ? 14
                          : null,
                  fontFamily: ar ? 'Amiri' : 'Quicksand',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
