import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:lottie/lottie.dart';
import 'package:markdown/markdown.dart' as md;

class Prerequisite extends StatefulWidget {
  static const ROUTE_NAME = "/prerequisite";

  @override
  _PrerequisiteState createState() => _PrerequisiteState();
}

class _PrerequisiteState extends State<Prerequisite> {
  ScrollController controller = ScrollController();
  var _extensionSet = MarkdownExtensionSet.githubFlavored;
  String data;
  Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    _composition = _loadComposition();
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('assets/lottie/loader.json');
    return await LottieComposition.fromByteData(assetData);
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
      body: CupertinoScrollbar(
        isAlwaysShown: true,
        controller: controller,
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
                        controller: controller,
                        key: Key(_extensionSet.name),
                        data: snapshot.data,
                        imageDirectory: 'https://raw.githubusercontent.com',
                        extensionSet: _extensionSet.value,
                        listItemCrossAxisAlignment:
                            MarkdownListItemCrossAxisAlignment.start,
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
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: FutureBuilder<LottieComposition>(
                    future: _composition,
                    builder: (context, snapshot) {
                      var composition = snapshot.data;
                      if (composition != null) {
                        return Lottie(composition: composition);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
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
