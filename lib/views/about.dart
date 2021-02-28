import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grafpix/icons.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
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
        'Islam Made Easy ${S.current.forPlatform} ${Platform.operatingSystem}';
    final legalese = '© ${DateTime.now().year} The IME team';
    // var now = new DateTime.now();
    // var nextUpdateTime = now.add(new Duration(days: 60)).month;
    return AlertDialog(
      title: ListHeader(
        text: MaterialLocalizations.of(context).aboutListTileTitle('IME'),
        trailing: IconButton(
          icon: FaIcon(
              isDesktop ? FontAwesomeIcons.timesCircle : PixIcon.typcn_times),
          onPressed: Get.back,
          splashRadius: isDesktop ? 10 : 20,
          tooltip: isDesktop
              ? MaterialLocalizations.of(context).closeButtonTooltip
              : null,
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
              height: isDesktop ? 322 : 200,
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
                !Platform.isAndroid || Platform.isIOS
                    ? "${Platform.operatingSystemVersion.replaceRange(23, 73, '')}"
                    : '',
                // 'Version: ${_updateInfo ?? '1.0.$nextUpdateTime'}',
                style: bodyTextStyle),
            Text(legalese, style: bodyTextStyle),
            isDesktop
                ? Semantics(
                    child: Text(
                    '━═══◎Share◎═══━',
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ))
                : Container(),
            isDesktop
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF59E1B),
                          borderRadius:
                              BorderRadius.circular(isDesktop ? 50 : 20),
                        ),
                        child: IconButton(
                          tooltip: 'Mail',
                          splashRadius: isDesktop ? 10 : 20,
                          icon: Icon(PixIcon.mail, color: Colors.white),
                          onPressed: () => launchURL(
                              'mailto:?subject=$name&body=${S.current.salam} $name ${S.current.shareText}. ${S.current.shareGetStoreText} https://snapcraft.io/islam-made-easy'),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff294C8C),
                          borderRadius:
                              BorderRadius.circular(isDesktop ? 50 : 20),
                        ),
                        child: IconButton(
                          tooltip: 'Facebook',
                          splashRadius: isDesktop ? 10 : 20,
                          icon: Icon(PixIcon.pix_facebook, color: Colors.white),
                          onPressed: () => launchURL(
                              'https://www.facebook.com/sharer/sharer.php?t=${S.current.salam} $name ${S.current.shareText}&quote=${S.current.shareGetStoreText}&ref=fbshare&u=https://snapcraft.io/islam-made-easy'),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff67C15E),
                          borderRadius:
                              BorderRadius.circular(isDesktop ? 50 : 20),
                        ),
                        child: IconButton(
                          tooltip: 'WhatsApp',
                          splashRadius: isDesktop ? 10 : 20,
                          icon: Icon(
                            PixIcon.pix_whatsapp,
                            color: Colors.white,
                          ),
                          onPressed: () => launchURL(
                              'https://wa.me/?text=${S.current.salam}\n$name ${S.current.shareText}.\n${S.current.shareGetStoreText} https://snapcraft.io/islam-made-easy'),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffA2A2A2),
                          borderRadius:
                              BorderRadius.circular(isDesktop ? 50 : 20),
                        ),
                        child: IconButton(
                            tooltip: MaterialLocalizations.of(context)
                                .copyButtonLabel,
                            splashRadius: isDesktop ? 10 : 20,
                            icon: Icon(PixIcon.pix_link, color: Colors.white),
                            onPressed: () {
                              HapticFeedback.heavyImpact();
                              Clipboard.setData(
                                ClipboardData(
                                    text:
                                        '${S.current.salam}\n$name ${S.current.shareText}.\n${S.current.shareGetStoreText}: https://snapcraft.io/islam-made-easy'),
                              ).then(
                                (value) => Get.snackbar(
                                  S.current.copiedToClipboardTitle,
                                  'Link copied',
                                  messageText: Row(
                                    children: [
                                      FaIcon(Icons.verified_user),
                                      Text(S.current.linkCopied),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  )
                : Container()
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
