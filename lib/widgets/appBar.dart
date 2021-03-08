import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class QnAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool isDesktop;

  const QnAppBar({Key key, this.title, this.isDesktop = false})
      : super(key: key);

  double get myAppBarHeight => 50;

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    return AppBar(
      title: Text(
        title,
        style:
            TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Quattrocento'),
        overflow: TextOverflow.fade,
      ),
      centerTitle: true,
      backwardsCompatibility: false,
      backgroundColor:
          isDesktop ? Colors.transparent : Theme.of(context).primaryColorDark,
      leading: isDesktop
          ? null
          : IconButton(
              icon: FaIcon(locale.languageCode == 'ar'
                  ? FontAwesomeIcons.angleRight
                  : FontAwesomeIcons.angleLeft),
              onPressed: Get.back,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            ),
      elevation: 0,
      automaticallyImplyLeading: isDesktop,
    );
  }

  @override
  Size get preferredSize => isDesktop
      ? Size.fromHeight(myAppBarHeight)
      : const Size.fromHeight(kToolbarHeight);
}
