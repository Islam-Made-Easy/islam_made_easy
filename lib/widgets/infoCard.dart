import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grafpix/icons.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';

import 'anim/anim.dart';

class InfoCard extends StatefulWidget {
  final String quest;
  final List<Widget> answers;

  const InfoCard({Key key, @required this.quest, @required this.answers})
      : super(key: key);

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  void _showSnackBarOnCopyFailure(Object exception) {
    Get.snackbar(S.current.copyError, exception);
  }

  @override
  void initState() {
    getPackageInfo();
    super.initState();
  }

  void getPackageInfo() async {
    if (!kIsWeb) {
      _packageInfo = await PackageInfo.fromPlatform();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return WidgetAnimator(
      Card(
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
        elevation: 0,
        // color: Theme.of(context).splashColor,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shadowColor: Colors.grey,
        child: ExpansionTile(
          // backgroundColor: Theme.of(context).splashColor,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: FaIcon(
                  PixIcon.pix_copy,
                  color: Colors.greenAccent.withOpacity(0.4),
                ),
                splashRadius: 10,
                tooltip: MaterialLocalizations.of(context).copyButtonLabel,
                onPressed: () => Clipboard.setData(
                  ClipboardData(text: widget.quest),
                )
                    .then(
                      (value) => Get.snackbar(S.current.copiedToClipboardTitle,
                          S.current.copiedToClipboard),
                    )
                    .catchError(_showSnackBarOnCopyFailure),
              ),
              kIsWeb
                  ? Container()
                  : !Platform.isAndroid
                      ? Container()
                      : IconButton(
                          icon: FaIcon(FontAwesomeIcons.shareAlt, size: 20),
                          splashRadius: 10,
                          onPressed: () =>
                              share(context, "𝗤. ${widget.quest}"),
                        ),
            ],
          ),
          expandedAlignment: Alignment.topCenter,
          tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          childrenPadding: EdgeInsets.symmetric(
              vertical: isDesktop ? 20 : 10, horizontal: isDesktop ? 30 : 10),
          title: Text(
            "𝗤. ${widget.quest}",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 17, fontFamily: 'Amiri', letterSpacing: 0.1),
          ),
          children: widget.answers,
        ),
      ),
    );
  }

  PackageInfo _packageInfo;

  share(BuildContext context, data) {
    final RenderBox box = context.findRenderObject();
    final shareText =
        "$data \nGet Answers and More Questions from ${_packageInfo.appName ?? 'Islam Made Easy'}, Version: ${_packageInfo.version}";
    Share.share(shareText,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
