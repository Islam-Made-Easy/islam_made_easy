import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:lottie/lottie.dart';
import 'package:markdown/markdown.dart' as md;

class Prerequisite extends StatefulWidget {
  @override
  _PrerequisiteState createState() => _PrerequisiteState();
}

class _PrerequisiteState extends State<Prerequisite> {
  var _extensionSet = MarkdownExtensionSet.githubFlavored;
  ScrollController controller = ScrollController();
  String data;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final textTheme = Theme.of(context).textTheme;
    Locale locale = Localizations.localeOf(context);
    preLang() {
      if (locale.languageCode == 'ar') {
        data = 'assets/md/intro_ar.md';
      } else if (locale.languageCode == 'sw') {
        data = 'assets/md/intro_sw.md';
      } else if (locale.languageCode == 'id') {
        data = 'assets/md/intro_id.md';
      } else {
        data = 'assets/md/intro.md';
      }
    }

    preLang();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Scrollbar(
        showTrackOnHover: true,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 30 : 1, vertical: 20),
          child: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString(data, cache: false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    SizedBox(height: 30),
                    Expanded(
                      child: Markdown(
                        key: Key(_extensionSet.name),
                        data: snapshot.data,
                        imageDirectory: 'https://raw.githubusercontent.com',
                        extensionSet: _extensionSet.value,
                        listItemCrossAxisAlignment:
                            MarkdownListItemCrossAxisAlignment.start,
                        // styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
                        styleSheet: MarkdownStyleSheet(
                          h1Align: WrapAlignment.center,
                          h1: TextStyle(
                              fontFamily: 'Amiri',
                              fontWeight: FontWeight.bold,
                              fontSize: isDesktop ? 40 : 30,
                              letterSpacing: -3,
                              color: Color(0xff404040)),
                          h2: textTheme.headline6.copyWith(
                              letterSpacing: 0.2,
                              decoration: TextDecoration.underline,
                              fontSize: isDesktop ? 35 : 24,
                              fontWeight: FontWeight.bold),
                          blockSpacing: isDesktop ? 25 : 10,
                          textScaleFactor: 1.0,
                          p: textTheme.bodyText1
                              .apply(fontFamily: 'Amiri', heightDelta: 1.8),
                        ),
                        selectable: true,
                        onTapLink: (text, href, title) =>
                            linkOnTapHandler(context, text, href, title),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Lottie.asset("assets/lottie/loader.json"));
              }
            },
          ),
        ),
      ),
    );
  }

  void linkOnTapHandler(
      BuildContext context, String text, String href, String title) async {
    showDialog(
      context: context,
      builder: (context) => _createDialog(context, text, href, title),
    );
  }

  Widget _createDialog(
          BuildContext context, String text, String href, String title) =>
      AlertDialog(
        title: Text('Reference Link'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(
                'See the following link for more information:',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 8),
              Text('Link text: $text'),
              SizedBox(height: 8),
              Text('Link destination: $href'),
              SizedBox(height: 8),
              Text('Link title: $title'),
            ],
          ),
        ),
        actions: [FlatButton(onPressed: Get.back, child: Text('OK'))],
      );
}

enum MarkdownExtensionSet { none, commonMark, githubFlavored, githubWeb }

extension MarkdownExtensionSetExtension on MarkdownExtensionSet {
  String get name => describeEnum(this);

  String get displayTitle => () {
        switch (this) {
          case MarkdownExtensionSet.none:
            return 'None';
          case MarkdownExtensionSet.commonMark:
            return 'Common Mark';
          case MarkdownExtensionSet.githubFlavored:
            return 'GitHub Flavored';
          case MarkdownExtensionSet.githubWeb:
            return 'GitHub Web';
        }
      }();

  md.ExtensionSet get value => () {
        switch (this) {
          case MarkdownExtensionSet.none:
            return md.ExtensionSet.none;
          case MarkdownExtensionSet.commonMark:
            return md.ExtensionSet.commonMark;
          case MarkdownExtensionSet.githubFlavored:
            return md.ExtensionSet.gitHubFlavored;
          case MarkdownExtensionSet.githubWeb:
            return md.ExtensionSet.gitHubWeb;
        }
      }();
}

extension WrapAlignmentExtension on WrapAlignment {
  String get name => describeEnum(this);

  String get displayTitle => () {
        switch (this) {
          case WrapAlignment.center:
            return 'Center';
          case WrapAlignment.end:
            return 'End';
          case WrapAlignment.spaceAround:
            return 'Space Around';
          case WrapAlignment.spaceBetween:
            return 'Space Between';
          case WrapAlignment.spaceEvenly:
            return 'Space Evenly';
          case WrapAlignment.start:
            return 'Start';
        }
      }();
}
