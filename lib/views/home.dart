import 'package:islam_made_easy/settings/settings.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/desktopNav.dart';
import 'package:islam_made_easy/widgets/feedback.dart' as feed;
import 'package:islam_made_easy/widgets/feedback.dart';
import 'package:islam_made_easy/widgets/panels/nav_panel.dart';
import 'about.dart' as about;

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
              elevation: 0.0,
              color: Theme.of(context).backgroundColor,
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(isPanelVisible ? 0.0 : 10),
              //     topRight: Radius.circular(isPanelVisible ? 0.0 : 10)),
              child: Column(
                children: <Widget>[Expanded(child: Center(child: MainPanel()))],
              ),
            ),
          )
        ],
      ),
    );
  }

  static DelayUI shareDelay = DelayUI(Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final isTablet = isDisplaySmallDesktop(context);
    final theme = Theme.of(context).backgroundColor;
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
            elevation: 0,
            backgroundColor: Colors.transparent,
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
              PopupMenuButton<MenuItem>(
                  onSelected: (item) => onSelected(context, item),
                  itemBuilder: (context) => [
                        ...MenuItems.itemsFirst.map(buildItem).toList(),
                      ]),
            ],
          ),
          body: LayoutBuilder(builder: bothPanels),
        ),
      );
    }
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
        value: item,
        child: Row(
          children: [
            FaIcon(item.icon,color: Theme.of(context).buttonColor),
            const SizedBox(width: 10),
            Text(item.text),
          ],
        ),
      );

  void onSelected(BuildContext context, MenuItem item) {
    Locale locale = Localizations.localeOf(context);
    final isDesktop = isDisplayDesktop(context);
    final ar = locale.languageCode == 'ar';
    switch (item) {
      case MenuItems.itemSetting:
        Get.to(() => Settings());
        break;
      case MenuItems.itemShare:
        about.showAboutDialog(context: context);
        break;
      case MenuItems.itemFeedback:
        isDesktop || (context.isTablet && DeviceOS.isDesktopOrWeb)
            ? Get.dialog(
                Align(
                  alignment: ar ? Alignment.centerLeft : Alignment.centerRight,
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
                ),
                transitionDuration:
                    DelayUI(Duration(milliseconds: 1000)).duration,
                transitionCurve: Curves.easeIn)
            : feed.showFeedbackDialog(
                context: context, isPanelVisible: isPanelVisible);
        break;
    }
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({this.text, this.icon});
}

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemSetting,
    itemShare,
    itemFeedback
  ];
  static const itemSetting = MenuItem(
    text: 'Settings',
    icon: FontAwesomeIcons.cog,
  );
  static const itemShare = MenuItem(
    text: 'About',
    icon: PixIcon.pix_info,
  );

  static const itemFeedback = MenuItem(
    text: 'Feedback',
    icon: FontAwesomeIcons.comment,
  );
}
