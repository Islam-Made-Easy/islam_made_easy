import 'dart:io';

import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/listHeader.dart';
import 'package:package_info/package_info.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

void showAboutDialog() {
  Get.dialog(
    AboutApp(),
    name: 'About IME',
    transitionCurve: Curves.easeIn,
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
    final isDesktop = isDisplayDesktop(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textButton =
        textTheme.button!.copyWith(letterSpacing: 2, fontFamily: 'Roboto');
    final name =
        'Islam Made Easy ${S.current.forPlatform} ${DeviceOS.isWeb ? 'Web' : Platform.operatingSystem}';
    final legalese = '${DateTime.now().year} The IME team';
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: ListHeader(
        text: local.aboutListTileTitle('IME'),
        trailing: IconButton(
          icon: FaIcon(
            DeviceOS.isMobile
                ? FontAwesomeIcons.shareNodes
                : FontAwesomeIcons.circleXmark,
          ),
          onPressed: () {
            DeviceOS.isDesktopOrWeb
                ? Get.back()
                : shareDelay.run(() => Share.share(
                    "Islam Made Easy\n${S.current.aboutApp}",
                    subject: ShareUtil().getPlatformShare()));
          },
          splashRadius: DeviceOS.isDesktopOrWeb ? 10 : 20,
          tooltip: local.closeButtonTooltip,
        ),
        ar: ar,
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image.asset(
              'assets/images/divi.png',
              scale: 3,
              color: Theme.of(context).primaryColor.withOpacity(.5),
            ),
            Image.asset(
              'assets/images/Logo3.png',
              height: isDesktop ? size.height * .3 : 150,
            ),
            FutureBuilder(
              future: getVersionNumber(),
              builder: (context, snapshot) => Text(
                snapshot.hasData
                    ? '$name \nVersion: ${snapshot.data}'
                    : '$name',
                textAlign: TextAlign.center,
                style: textTheme.caption!.copyWith(
                  letterSpacing: .5,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
            ),
            Text(
              S.current.aboutApp,
              style: textButton.copyWith(fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            Shimmer.fromColors(
              highlightColor: colorScheme.onBackground,
              loop: 2,
              baseColor: colorScheme.primary,
              child: GestureDetector(
                onTap: () => launchURL('https://github.com/Islam-Made-Easy/'),
                child: Text(
                  legalese,
                  style: textButton.copyWith(
                    fontWeight: FontWeight.w400,
                    height: 2,
                    decoration: TextDecoration.underline,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
            ),
            Text(
              '━═══◎${S.current.share}◎═══━',
              style: TextStyle(color: colorScheme.secondary),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShareButtons(
                  onPressed: () => launchURL(
                      'mailto:?subject=$name&body=$name ${S.current.shareText} ${ShareUtil().getPlatformShare()}'),
                  tip: 'Mail',
                  color: Color(0xffF59E1B),
                  icon: Icons.mail,
                ),
                ShareButtons(
                  onPressed: () => launchURL(
                      'https://www.facebook.com/sharer/sharer.php?t=$name ${S.current.aboutApp}&quote=Get it from Now:&ref=fbshare&u=${ShareUtil().getPlatformShare()}'),
                  tip: 'Facebook',
                  color: Color(0xff2114BE),
                  icon: FontAwesomeIcons.facebook,
                ),
                ShareButtons(
                  onPressed: () => launchURL(
                      'https://twitter.com/intent/tweet?url=${ShareUtil().getPlatformShare()}&text=Get $name. An ${S.current.aboutApp}&via=ime_app'),
                  tip: 'Twitter',
                  color: Color(0xff0133fd),
                  icon: FontAwesomeIcons.twitter,
                ),
                ShareButtons(
                  onPressed: () => launchURL(
                      'https://wa.me/?text=$name ${S.current.aboutApp}.\nGet it Now from: ${ShareUtil().getPlatformShare()}'),
                  tip: 'WhatsApp',
                  color: Color(0xff11C11E),
                  icon: FontAwesomeIcons.whatsapp,
                ),
                ShareButtons(
                  onPressed: () {
                    shareDelay.run(
                      () => Clipboard.setData(
                        ClipboardData(
                            text:
                                '$name ${S.current.aboutApp}.\nGet it from Now: ${ShareUtil().getPlatformShare()}'),
                      ).then((value) {
                        setState(() => verified = true);
                      }),
                    );
                  },
                  color: Color(0xFF666666),
                  tip: verified ? "Link Copied" : local.copyButtonLabel,
                  icon: verified ? Icons.verified_user : FontAwesomeIcons.link,
                ),
              ],
            ),
            Image.asset(
              'assets/images/1.png',
              scale: 3,
              color: Theme.of(context).primaryColor.withOpacity(.5),
            )
          ],
        ),
      ),
    );
  }
}

Future launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
