import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grafpix/icons.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/widgets/buttons/shareButton.dart';
import 'package:islam_made_easy/widgets/listHeader.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
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
  // AppUpdateInfo _updateInfo;

  Future<String> getVersionNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        // _updateInfo = info;
      });
    }).catchError((e) => _showError(e));
  }

  void _showError(dynamic exception) {
    Get.snackbar('Error!', exception.toString());
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bodyTextStyle =
        textTheme.bodyText1.apply(color: colorScheme.onPrimary);
    final name =
        'Islam Made Easy ${S.current.forPlatform} ${kIsWeb ? 'Web' : Platform.operatingSystem}';
    final legalese = '© ${DateTime.now().year} The IME team';
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return AlertDialog(
      title: ListHeader(
        text: MaterialLocalizations.of(context).aboutListTileTitle('IME'),
        trailing: IconButton(
          icon: FaIcon(isDesktop
              ? FontAwesomeIcons.timesCircle
              : FontAwesomeIcons.share),
          onPressed: () {
            isDesktop ? Get.back() : share(context);
          },
          splashRadius: isDesktop ? 10 : 20,
          tooltip: isDesktop
              ? MaterialLocalizations.of(context).closeButtonTooltip
              : null,
        ),
      ),
      shape: RoundedRectangleBorder(
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
              height: isDesktop ? 300 : 200,
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
                !kIsWeb
                    ? !Platform.isAndroid || !Platform.isIOS
                        ? "${Platform.operatingSystemVersion.replaceRange(23, 73, '')}"
                        : ''
                    : "",
                // 'Version: ${_updateInfo ?? '1.0.$nextUpdateTime'}',
                style: bodyTextStyle),
            Text(legalese, style: bodyTextStyle),
            isDesktop
                ? Semantics(
                    child: Text(
                    '━═══◎${S.current.share}◎═══━',
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ))
                : Container(),
            isDesktop
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShareButtons(
                        color: Color(0xffF59E1B),
                        tip: 'Mail',
                        icon: PixIcon.mail,
                        onPressed: () => launchURL(
                            'mailto:?subject=$name&body=${S.current.salam} $name ${S.current.shareText}. ${S.current.shareGetStoreText} https://islam-made-easy.web.app'),
                      ),
                      ShareButtons(
                        color: Color(0xff294C8C),
                        tip: 'Facebook',
                        icon: PixIcon.pix_facebook,
                        onPressed: () => launchURL(
                            'https://www.facebook.com/sharer/sharer.php?t=${S.current.salam} $name ${S.current.shareText}&quote=${S.current.shareGetStoreText}&ref=fbshare&u=https://islam-made-easy.web.app'),
                      ),
                      ShareButtons(
                        color: Color(0xff67C15E),
                        tip: 'WhatsApp',
                        icon: PixIcon.pix_whatsapp,
                        onPressed: () => launchURL(
                            'https://wa.me/?text=${S.current.salam}\n$name ${S.current.shareText}.\n${S.current.shareGetStoreText} https://islam-made-easy.web.app'),
                      ),
                      ShareButtons(
                          color: Color(0xffA2A2A2),
                          tip:
                              MaterialLocalizations.of(context).copyButtonLabel,
                          icon: PixIcon.pix_link,
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                            Clipboard.setData(
                              ClipboardData(
                                  text:
                                      '${S.current.salam}\n$name ${S.current.shareText}.\n${S.current.shareGetStoreText}: https://islam-made-easy.web.app'),
                            ).then(
                              (value) => Get.snackbar(
                                S.current.copiedToClipboardTitle,
                                S.current.linkCopied,
                                messageText: Row(
                                  children: [
                                    FaIcon(Icons.verified_user,
                                        color: Theme.of(context).accentColor),
                                    Text(S.current.linkCopied),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  share(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    final shareText = "Islam Made Easy\n${S.current.aboutApp}";
    Share.share(shareText,
        subject: 'https://islam-made-easy.web.app',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}

Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
