import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/layout/adaptive.dart';

void showFeedbackDialog({@required BuildContext context}) {
  final isDesktop = isDisplayDesktop(context);
  assert(context != null);
  showAnimatedDialog<void>(
    context: context,
    barrierDismissible: !isDesktop,
    animationType: DialogTransitionType.size,
    builder: (context) => AppFeedback(),
  );
}

class AppFeedback extends StatelessWidget {
  final feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          FaIcon(FontAwesomeIcons.fan),
          Text('Feedback'),
        ],
      ),
      actions: [
        IconButton(
          icon: FaIcon(FontAwesomeIcons.timesCircle),
          onPressed: Get.back,
          splashRadius: 10,
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
        ),
      ],
      content: Column(
        children: [
          TextFormField(
            onChanged: (value) {},
            controller: feedbackController,
            autocorrect: true,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
              hintText: ' Leave product feedback \nor share your ideas',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xfff2f2f2), width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
