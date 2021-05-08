import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/desktopNav.dart';
import 'package:islam_made_easy/widgets/feedback.dart' as feed;
import 'package:islam_made_easy/widgets/feedback.dart';
import 'package:islam_made_easy/widgets/panels/nav_panel.dart';

class Home extends StatefulWidget {
  static const ROUTE_NAME = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController controller;
  static const header_height = 100.0;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300), value: 1.0);
    super.initState();
  }

  @override
  void setState(fn) {
    isPanelVisible;
    super.setState(fn);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    final frontPanelHeight = -header_height;

    return RelativeRectTween(
            begin: RelativeRect.fromLTRB(
                0.0, backPanelHeight, 0.0, frontPanelHeight),
            end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Container(
      child: Stack(
        children: <Widget>[
          NavigationPanel(),
          PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: Material(
              elevation: 12.0,
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isPanelVisible ? 0.0 : 10),
                  topRight: Radius.circular(isPanelVisible ? 0.0 : 10)),
              child: Column(
                children: <Widget>[Expanded(child: Center(child: MainPanel()))],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final isTablet = isDisplaySmallDesktop(context);
    final theme = Theme.of(context).backgroundColor;
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    if (DeviceOS.isDesktopOrWeb && isDesktop ||
        (context.isLargeTablet && DeviceOS.isMobile)) {
      return Scaffold(
        backgroundColor: theme,
        body: DesktopNav(extended: !isTablet),
      );
    } else {
      return DoubleBack(
        onFirstBackPress: (context) => Get.snackbar('', "Smile It's Sunnah"),
        child: Scaffold(
          backgroundColor: theme,
          appBar: AppBar(
            title: Text(
              isPanelVisible ? "Islam Made Easy" : "I M E",
              style: kIsWeb
                  ? Theme.of(context).textTheme.caption.copyWith(
                        fontSize: 25.0,
                        fontFamily: 'Quattrocento',
                        fontWeight: FontWeight.normal,
                      )
                  : TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Quattrocento',
                      fontWeight: FontWeight.normal,
                    ),
            ),
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                double velocity = 2.0;
                controller.fling(
                    velocity: isPanelVisible ? -velocity : velocity);
              },
              icon: AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                size: 30,
                progress: controller.view,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  isDesktop || (context.isTablet && DeviceOS.isDesktopOrWeb)
                      ? Get.dialog(
                          Align(
                            alignment: ar
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              height: double.infinity,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                color: Color(0xFFFAFAFC),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(ar ? 0 : 20),
                                  bottomRight: Radius.circular(ar ? 20 : 0),
                                  bottomLeft: Radius.circular(ar ? 0 : 20),
                                  topRight: Radius.circular(ar ? 20 : 0),
                                ),
                              ),
                              child: AppFeedback(),
                            ),
                          ),transitionDuration: DelayUI(Duration(milliseconds: 1000)).duration,
                          transitionCurve: Curves.easeIn)
                      : feed.showFeedbackDialog(
                          context: context, isPanelVisible: isPanelVisible);
                },
                icon: FaIcon(isPanelVisible
                    ? FontAwesomeIcons.comment
                    : FontAwesomeIcons.commentDots),
              ),
            ],
          ),
          body: LayoutBuilder(builder: bothPanels),
        ),
      );
    }
  }
}
