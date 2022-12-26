import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/settings/settings.dart';
import 'package:islam_made_easy/views/prerequisite.dart';
import 'package:quick_actions/quick_actions.dart';

import '../views/quiz/quiz_home.dart';

class QuickUtil extends StatefulWidget {
  final Widget? child;

  const QuickUtil({Key? key, this.child}) : super(key: key);

  @override
  _QuickUtilState createState() => _QuickUtilState();
}

class _QuickUtilState extends State<QuickUtil> {
  static const QuickActions quickActions = QuickActions();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setupQuickActions();
    _handleQuickActions();
  }

  _setupQuickActions() {
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
          type: 'action_prerequisite',
          localizedTitle: S.current.prerequisite,
          icon: 'ic_menu_home'),
      ShortcutItem(
          type: 'action_quiz',
          localizedTitle: S.current.quiz,
          icon: 'ic_menu_quiz'),
      ShortcutItem(
          type: 'action_settings',
          localizedTitle: S.current.settings,
          icon: 'ic_settings'),
    ]);
  }

  _handleQuickActions() {
    quickActions.initialize((String shortcutType) {
      setState(() {
        if (shortcutType == 'action_prerequisite') {
          Get.off(() => Prerequisite());
        } else if (shortcutType == 'action_quiz') {
          Get.off(() => QuizHome());
        } else if (shortcutType == 'action_settings') {
          Get.off(() => Settings());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) => widget.child!;
}
