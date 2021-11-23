import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/settings/settings.dart';
import 'package:islam_made_easy/utils/device_info.dart';
import 'package:islam_made_easy/views/home.dart';
import 'package:islam_made_easy/views/prerequisite.dart';
import 'package:quick_actions/quick_actions.dart';
// import 'package:system_tray/system_tray.dart';
// import 'package:path/path.dart' as p;
// import 'package:bitsdojo_window/bitsdojo_window.dart';

class QuickUtil extends StatefulWidget {
  final Widget? child;

  const QuickUtil({Key? key, this.child}) : super(key: key);

  @override
  _QuickUtilState createState() => _QuickUtilState();
}

class _QuickUtilState extends State<QuickUtil> {
  final QuickActions quickActions = QuickActions();
  // final SystemTray systemTray = SystemTray();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setupQuickActions();
    _handleQuickActions();
    // _setupSysTray();
    // _handleSystray();
  }

  void _setupQuickActions() {
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
          type: 'action_home', localizedTitle: S.current.prerequisite, icon: 'ic_menu_home'),
      ShortcutItem(
          type: 'action_quiz_start',
          localizedTitle: S.current.quiz,
          icon: 'ic_menu_quiz'),
      ShortcutItem(
          type: 'action_settings',
          localizedTitle: S.current.settings,
          icon: 'ic_settings'),
    ]);
  }

  // void _setupSysTray() async {
  //   String path;
  //   if (DeviceOS.isWindows) {
  //     path = p.joinAll([
  //       p.dirname(Platform.resolvedExecutable),
  //       'data/flutter_assets/assets',
  //       'app_icon.ico'
  //     ]);
  //   } else if (DeviceOS.isMacOS) {
  //     path = p.joinAll(['AppIcon']);
  //   } else {
  //     path = p.joinAll([
  //       p.dirname(Platform.resolvedExecutable),
  //       'data/flutter_assets/assets',
  //       'app_icon.png'
  //     ]);
  //   }
  //   await systemTray.initSystemTray("IME",
  //       iconPath: path, toolTip: "How to use IME, Insider");
  // }

  void _handleQuickActions() {
    quickActions.initialize((String shortcutType) {
      if (shortcutType == 'action_quiz_start') {
        Get.to(() => Prerequisite());
      } else if (shortcutType == 'action_home') {
        Get.to(() => Home());
      } else if (shortcutType == 'action_settings') {
        Get.to(() => Settings());
      }
    });
  }

  // void _handleSystray() async {
  //   await systemTray.setContextMenu(
  //     [
  //       MenuItem(
  //         label: 'Show',
  //         onClicked: () {
  //           appWindow.show();
  //         },
  //       ),
  //       MenuSeparator(),
  //       SubMenu(
  //         label: "Quiz",
  //         children: [
  //           MenuItem(
  //             label: 'True & False',
  //             enabled: false,
  //             onClicked: () {
  //               print("click SubItem1");
  //             },
  //           ),
  //           MenuItem(label: 'Multiple'),
  //           MenuItem(label: 'SubItem3'),
  //         ],
  //       ),
  //       MenuSeparator(),
  //       MenuItem(
  //         label: 'Settings',
  //         onClicked: () {
  //           appWindow.restore();
  //         },
  //       ),        MenuSeparator(),
  //       MenuItem(
  //         label: 'Exit',
  //         onClicked: () {
  //           appWindow.close();
  //         },
  //       ),
  //     ],
  //   );
  //   // handle system tray event
  //   systemTray.registerSystemTrayEventHandler((eventName) {
  //     print("eventName: $eventName");
  //   });
  // }

  @override
  Widget build(BuildContext context) => widget.child!;
}
