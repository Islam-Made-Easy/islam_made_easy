import 'package:flutter/material.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';

class QnAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool isDesktop;
  final Color color;

  const QnAppBar({Key key, this.title, this.isDesktop = false, this.color})
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
      backgroundColor: color,
      leading: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.arrowLeft):
              const ButtonActivateIntent(),
        },
        child: isDesktop
            ? BackButton()
            : IconButton(
                key: const ValueKey('Exit'),
                icon: FaIcon(locale.languageCode == 'ar'
                    ? FontAwesomeIcons.angleRight
                    : FontAwesomeIcons.angleLeft),
                onPressed: Get.back,
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              ),
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => isDesktop
      ? Size.fromHeight(myAppBarHeight)
      : const Size.fromHeight(kToolbarHeight);
}
