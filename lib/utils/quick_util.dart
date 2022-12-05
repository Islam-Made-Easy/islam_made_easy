import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/settings/settings.dart';
import 'package:islam_made_easy/views/home.dart';
import 'package:islam_made_easy/views/prerequisite.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickUtil extends StatefulWidget {
  final Widget? child;

  const QuickUtil({Key? key, this.child}) : super(key: key);

  @override
  _QuickUtilState createState() => _QuickUtilState();
}

class _QuickUtilState extends State<QuickUtil> {
  final QuickActions quickActions = QuickActions();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setupQuickActions();
    _handleQuickActions();
  }

  void _setupQuickActions() {
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
          type: 'action_home',
          localizedTitle: S.current.prerequisite,
          icon: 'ic_menu_home'),
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

  void _handleQuickActions() {
    quickActions.initialize((String shortcutType) {
      if (shortcutType == 'action_quiz_start') {
        Get.off(() => Prerequisite());
      } else if (shortcutType == 'action_home') {
        Get.off(() => Home());
      } else if (shortcutType == 'action_settings') {
        Get.off(() => Settings());
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child!;
}
