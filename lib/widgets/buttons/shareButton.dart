import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islam_made_easy/layout/adaptive.dart';

class ShareButtons extends StatelessWidget {
  final String tip;
  final Color color;
  final IconData icon;
  final Function onPressed;

  const ShareButtons({Key key, this.color, this.icon, this.onPressed, this.tip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(isDesktop ? 50 : 20),
      ),
      child: IconButton(
        icon: FaIcon(icon, color: Colors.white),
        onPressed: onPressed,
        tooltip: tip,
        splashRadius: isDesktop ? 10 : 20,
      ),
    );
  }
}
