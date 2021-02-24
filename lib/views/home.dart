import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/services/daily.dart';
import 'package:islam_made_easy/widgets/desktopNav.dart';
import 'package:islam_made_easy/widgets/panels/mainPanel.dart';
import 'package:islam_made_easy/widgets/panels/nav_panel.dart';
import 'package:liquid_ui/liquid_ui.dart';

import '../layout/adaptive.dart';

class Home extends StatefulWidget {
  static const ROUTE_NAME = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController controller;
  static const header_height = 100.0;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300), value: 1.0);
    DailyNotification().getQuoteString();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      DailyNotification().init();
    }
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
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
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
    if (isDesktop) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: DesktopNav(extended: !isTablet),
      );
    } else {
      return DoubleBack(
        onFirstBackPress: (context) => Get.snackbar('😊️', "Smile It's Sunnah"),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: LText(
              isPanelVisible
                  ? "Islam Made Easy"
                  : "\l.lead.bold{I} \l.lead.bold{M} \l.lead.bold{E}",
              baseStyle: TextStyle(
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
          ),
          body: LayoutBuilder(builder: bothPanels),
        ),
      );
    }
  }
}
