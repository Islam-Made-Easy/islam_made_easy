import 'dart:io';
import 'dart:ui';

import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/listHeader.dart';
import 'package:package_info/package_info.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

void showAboutDialog({required BuildContext context}) {
  showAnimatedDialog<void>(
    context: context,
    barrierDismissible: true,
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
    final MaterialLocalizations local = MaterialLocalizations.of(context);
    print(window.physicalSize);
    final isDesktop = isDisplayDesktop(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textButton = textTheme.button!.copyWith(letterSpacing: 2,fontFamily: 'Roboto');
    final name =
        'Islam Made Easy ${S.current.forPlatform} ${DeviceOS.isWeb ? 'Web' : Platform.operatingSystem.capitalizeFirst}';
    final legalese = '${DateTime.now().year} The IME team';
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: ListHeader(
        text: local.aboutListTileTitle('IME'),
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
          tooltip: local.closeButtonTooltip ,
        ), ar: ar,
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Divider(),
            Image.asset(
              'assets/images/logo.png',
              height: isDesktop ? size.height * 0.3 : 150,
            ),
            FutureBuilder(
              future: getVersionNumber(),
              builder: (context, snapshot) =>
                  Text(
                    snapshot.hasData
                        ? '$name \nVersion: ${snapshot.data}'
                        : '$name',
                    textAlign: TextAlign.center,
                    style: textTheme.caption!.copyWith(letterSpacing: .5,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 28),
                  ),
            ),
            Text(S.current.aboutApp, style: textButton.copyWith(
                fontFamily: ar ? 'Amiri' : 'Roboto',
                fontWeight: FontWeight.w300),textAlign: TextAlign.center),
            Shimmer.fromColors(
              highlightColor: colorScheme.onBackground,
              loop: 2,
              baseColor: colorScheme.primary,
              child: Text(legalese, style: textButton.copyWith(
                  fontWeight: FontWeight.w400, height: 2)),
            ),
            Text(
              '━═══◎${S.current.share}◎═══━',
              style: TextStyle(color: colorScheme.secondary),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShareButtons(
                  tip: 'Mail',
                  icon: FaIcon(Icons.mail,color: Color(0xffF59E1B)),
                  onPressed: () => launchURL(
                      'mailto:?subject=$name&body=$name ${S.current.shareText} ${ShareUtil().getPlatformShare()}'),
                ),
                ShareButtons(
                  tip: 'Facebook',
                  icon: Lottie.asset('assets/lottie/Ficon.json',height: 50,repeat: false),
                  onPressed: () => launchURL(
                      'https://www.facebook.com/sharer/sharer.php?t=$name ${S.current.aboutApp}&quote=Get it from Now:&ref=fbshare&u=${ShareUtil().getPlatformShare()}'),
                ),
                ShareButtons(
                  tip: 'WhatsApp',
                  icon: FaIcon(FontAwesomeIcons.whatsapp,color: Color(0xff67C15E)),
                  onPressed: () => launchURL(
                      'https://wa.me/?text=$name ${S.current.aboutApp}.\nGet it from Now: ${ShareUtil().getPlatformShare()}'),
                ),
                AnimatedSwitcher(
                  duration: shareDelay.duration,
                  child: ShareButtons(
                      tip: verified ? "Link Copied" : local.copyButtonLabel,
                      icon: FaIcon(verified?Icons.verified_user:FontAwesomeIcons.link,color: Color(0xffA2A2A2)),
                      onPressed: () {
                        shareDelay.run(
                              () => Clipboard.setData(
                            ClipboardData(
                                text:
                                '$name ${S.current.aboutApp}.\nGet it from Now: ${ShareUtil().getPlatformShare()}'),
                          ).then((value) {setState(() => verified = true);}),
                        );
                      }),
                ),
              ],
            )
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