import 'package:islam_made_easy/settings/settings.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/views/about.dart' as about;
import 'package:islam_made_easy/widgets/feedback.dart' as feed;

enum MenuOptions { Settings, about, feed }

class PopupOptionMenu extends StatelessWidget {
  final bool? isVisible;

  const PopupOptionMenu({Key? key, this.isVisible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final isDesktop = isDisplayDesktop(context);
    final ar = locale.languageCode == 'ar';
    final color = Theme.of(context).iconTheme.color;
    return PopupMenuButton(
      icon: FaIcon(FontAwesomeIcons.ellipsisV),elevation: 0,
      onSelected: (MenuOptions options) async {
        switch (options) {
          case MenuOptions.Settings:
            Get.to(() => Settings());
            break;
          case MenuOptions.about:
            about.showAboutDialog();
            break;
          case MenuOptions.feed:
            isDesktop || (context.isTablet && DeviceOS.isDesktopOrWeb)
                ? Get.dialog(FeedDialog(ar: ar),
                    transitionDuration:
                        DelayUI(Duration(milliseconds: 1000)).duration,
                    transitionCurve: Curves.easeIn)
                : feed.showFeedbackDialog(context, isVisible!);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
        PopupMenuItem(
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.info, color: color),
              const SizedBox(width: 10),
              Text(MaterialLocalizations.of(context).aboutListTileTitle(''),style: TextStyle(fontFamily: 'Quicksand'),),
            ],
          ),
          value: MenuOptions.about,
        ),
        PopupMenuItem(
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.cog,color: color),
              const SizedBox(width: 10),
              Text(S.current.settings,style: TextStyle(fontFamily: 'Quicksand'),),
            ],
          ),
          value: MenuOptions.Settings,
        ),
        PopupMenuItem(
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.comment,color: color),
              const SizedBox(width: 10),
              Text(S.current.sendFeed,style: TextStyle(fontFamily: 'Quicksand'),),
            ],
          ),
          value: MenuOptions.feed,
        ),
      ],
    );
  }
}

class FeedDialog extends StatelessWidget {
  const FeedDialog({Key? key, required this.ar}) : super(key: key);

  final bool ar;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: ar ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          color: context.isDarkMode?Theme.of(context).scaffoldBackgroundColor:Color(0xFFFAFAFC),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ar ? 0 : 20),
            bottomRight: Radius.circular(ar ? 20 : 0),
            bottomLeft: Radius.circular(ar ? 0 : 20),
            topRight: Radius.circular(ar ? 20 : 0),
          ),
        ),
        child: Stack(
          children: [
            GradientCircles(),
            feed.AppFeedback(),
          ],
        ),
      ),
    );
  }
}
