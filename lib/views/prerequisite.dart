import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/widgets/anim/load_indicator.dart';
import 'package:markdown/markdown.dart' as md;

class Prerequisite extends StatefulWidget {
  static const ROUTE_NAME = "/prerequisite";

  @override
  _PrerequisiteState createState() => _PrerequisiteState();
}

class _PrerequisiteState extends State<Prerequisite> {
  var _extensionSet = MarkdownExtensionSet.githubFlavored;
  late String data;

  @override
  Widget build(BuildContext context) {
    final dp = isDisplayDesktop(context);
    final theme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).languageCode;
    preLang() {
      if (locale == 'ar') {
        data = 'assets/md/intro_ar.md';
      } else if (locale == 'sw') {
        data = 'assets/md/intro_sw.md';
      } else if (locale == 'id') {
        data = 'assets/md/intro_id.md';
      } else {
        data = 'assets/md/intro.md';
      }
    }

    preLang();
    return Scaffold(
      backgroundColor: context.isDarkMode ? null : Theme.of(context).primaryColorLight,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dp ? 30 : 1, vertical: 20),
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString(data, cache: false),
          builder: (context,AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  SizedBox(height: 30),
                  Expanded(
                    child: Markdown(
                      key: Key(_extensionSet.name),
                      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      data: snapshot.data,
                      extensionSet: _extensionSet.value,
                      listItemCrossAxisAlignment: MarkdownListItemCrossAxisAlignment.start,
                      styleSheet: MarkdownStyleSheet(
                        h1Align: WrapAlignment.center,
                        h1: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: dp ? 40 : 30,
                            letterSpacing: -3,
                            color: Color(0xff404040)),
                        h2: theme.headline6!.copyWith(
                            letterSpacing: .2,
                            decoration: TextDecoration.underline,
                            fontSize: dp ? 35 : 24,
                            fontWeight: FontWeight.w500),
                        p: theme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w100,
                            height: dp ? 1.85 : 1.8,
                            fontSize: dp ? 17 : 15),
                        blockquote: theme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w100,
                            height: dp ? 1.85 : 1.8,
                            fontSize: dp ? 17 : 15),
                        strong: theme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600,
                            height: dp ? 1.85 : 1.8,
                            fontSize: dp ? 17 : 15),
                        blockSpacing: dp ? 25 : 10,
                        textScaleFactor: 1.0,
                      ),
                      selectable: true,
                      shrinkWrap: true,
                    ),
                  ),
                ],
              );
            }
              return LoadingIndicator();
          },
        ),
      ),
    );
  }
}

enum MarkdownExtensionSet { none, commonMark, githubFlavored, githubWeb }

extension MarkdownExtensionSetExtension on MarkdownExtensionSet {
  String get name => describeEnum(this);

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
