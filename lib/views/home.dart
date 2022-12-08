import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/desktopNav.dart';
import 'package:islam_made_easy/widgets/panels/nav_panel.dart';
import 'package:islam_made_easy/widgets/popup_menu.dart';

class Home extends StatefulWidget {
  static const ROUTE_NAME = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController controller;
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
                .0, backPanelHeight, .0, frontPanelHeight),
            end: RelativeRect.fromLTRB(.0, .0, .0, .0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Stack(
      children: <Widget>[
        NavigationPanel(),
        PositionedTransition(
          rect: getPanelAnimation(constraints),
          child: Container(
            color: context.isDarkMode
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).backgroundColor,
            child: Column(
              children: <Widget>[Expanded(child: Center(child: MainPanel()))],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final isTablet = isDisplaySmallDesktop(context);
    if (DeviceOS.isDesktopOrWeb && isDesktop ||
        (context.isLargeTablet && DeviceOS.isMobile)) {
      return Scaffold(
        body: WindowBorder(
          color: Get.theme.primaryColor,
          width: 1,
          child: DesktopNav(extended: !isTablet),
        ),
      );
    } else {
      return DoubleBack(
        onFirstBackPress: (context) => Get.snackbar('Smile It\'s Sunnah', ''),
        child: Scaffold(
          backgroundColor: context.isDarkMode
              ? null
              : Theme.of(context).secondaryHeaderColor,
          appBar: AppBar(
            // backgroundColor: context.isDarkMode?Theme.of(context).primaryColorDark: Theme.of(context).primaryColorLight,
            leading: IconButton(
              onPressed: () {
                double velocity = 2.0;
                controller.fling(
                    velocity: isPanelVisible ? -velocity : velocity);
              },
              splashRadius: 10,
              icon: AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                size: 30,
                progress: controller.view,
              ),
            ),
            actions: [PopupOptionMenu(isVisible: isPanelVisible)],
          ),
          body: LayoutBuilder(builder: bothPanels),
        ),
      );
    }
  }
}
