import 'dart:io';
import 'dart:ui';

import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/listHeader.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

void showAboutDialog({@required BuildContext context}) {
  final isDesktop = isDisplayDesktop(context);
  assert(context != null);
  showAnimatedDialog<void>(
    context: context,
    barrierDismissible: !isDesktop,
    animationType: DialogTransitionType.size,
    builder: (context) => AboutApp(),
  );
}

class AboutApp extends StatefulWidget {
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  Future<String> getVersionNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  bool verified = false;
  static DelayUI shareDelay = DelayUI(Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    print(window.physicalSize);
    final isDesktop = isDisplayDesktop(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bodyTextStyle =
        textTheme.bodyText1.apply(color: colorScheme.onPrimary);
    final name =
        'Islam Made Easy ${S.current.forPlatform} ${DeviceOS.isWeb ? 'Web' : Platform.operatingSystem}';
    final legalese = '© ${DateTime.now().year} The IME team';
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: ListHeader(
        text: MaterialLocalizations.of(context).aboutListTileTitle('IME'),
        trailing: IconButton(
          icon: FaIcon(DeviceOS.isMobile
              ? FontAwesomeIcons.shareAlt
              : FontAwesomeIcons.timesCircle),
          onPressed: () {
            DeviceOS.isDesktopOrWeb
                ? Get.back()
                : shareDelay.run(() => Share.share(
                    "Islam Made Easy\n${S.current.aboutApp}",
                    subject: ShareUtil().getPlatformShare()));
          },
          splashRadius: DeviceOS.isDesktopOrWeb ? 10 : 20,
          tooltip: DeviceOS.isDesktopOrWeb
              ? MaterialLocalizations.of(context).closeButtonTooltip
              : null,
        ),
      ),
      shape: DeviceOS.isWeb
          ? RoundedRectangleBorder()
          : RoundedRectangleBorder(
              side: BorderSide(width: 0.5, color: Theme.of(context).hoverColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ar ? 0 : 10),
                topRight: Radius.circular(ar ? 10 : 0),
                bottomRight:
                    ar ? Radius.elliptical(90, 10) : Radius.elliptical(12, 200),
                bottomLeft:
                    ar ? Radius.elliptical(12, 200) : Radius.elliptical(90, 10),
              ),
            ),
      backgroundColor: Color(0xfff2f2f2),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Divider(),
            Image.asset(
              'assets/images/logo.png',
              height: isDesktop ? size.height * 0.3 : 150,
            ),
            Text(S.current.aboutApp),
            FutureBuilder(
              future: getVersionNumber(),
              builder: (context, snapshot) => Text(
                snapshot.hasData
                    ? '$name \nVersion: ${snapshot.data}'
                    : '$name',
                textAlign: TextAlign.center,
                style: textTheme.headline4.apply(color: colorScheme.onPrimary),
              ),
            ),
            Text(
                DeviceOS.isDesktop
                    ? "${Platform.operatingSystemVersion.replaceRange(23, 73, '')}"
                    : '',
                style: bodyTextStyle),
            Text(legalese, style: bodyTextStyle),
            if (isDesktop || DeviceOS.isDesktopOrWeb)
              Text(
                '━═══◎${S.current.share}◎═══━',
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              )
            else
              Container(),
            if (isDesktop ||
                DeviceOS.isDesktopOrWeb ||
                (context.isTablet && !context.isPhone))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShareButtons(
                    color: Color(0xffF59E1B),
                    tip: 'Mail',
                    icon: PixIcon.mail,
                    onPressed: () => launchURL(
                        'mailto:?subject=$name&body=$name ${S.current.shareText} ${ShareUtil().getPlatformShare}'),
                  ),
                  ShareButtons(
                    color: Color(0xff294C8C),
                    tip: 'Facebook',
                    icon: PixIcon.pix_facebook,
                    onPressed: () => launchURL(
                        'https://www.facebook.com/sharer/sharer.php?t=$name ${S.current.aboutApp}&quote=Get it from Now:&ref=fbshare&u=${ShareUtil().getPlatformShare}'),
                  ),
                  ShareButtons(
                    color: Color(0xff67C15E),
                    tip: 'WhatsApp',
                    icon: PixIcon.pix_whatsapp,
                    onPressed: () => launchURL(
                        'https://wa.me/?text=$name ${S.current.aboutApp}.\nGet it from Now: ${ShareUtil().getPlatformShare}'),
                  ),
                  ShareButtons(
                      color: Color(0xffA2A2A2),
                      tip: verified
                          ? "Link Copied"
                          : MaterialLocalizations.of(context).copyButtonLabel,
                      icon: verified ? Icons.verified_user : PixIcon.pix_link,
                      onPressed: () {
                        shareDelay.run(
                          () => Clipboard.setData(
                            ClipboardData(
                                text:
                                    '$name ${S.current.aboutApp}.\nGet it from Now: ${ShareUtil().getPlatformShare}'),
                          ).then((value) {
                            setState(() {
                              HapticFeedback.heavyImpact();
                              verified = true;
                            });
                          }),
                        );
                      }),
                ],
              )
            else
              Container()
          ],
        ),
      ),
    );
  }
}

Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
