import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/settings/settings_pro.dart';
import 'package:islam_made_easy/utils/download_util.dart';
import 'package:islam_made_easy/widgets/anim/load_indicator.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class Prerequisite extends StatefulWidget {
  static const ROUTE_NAME = "/prerequisite";

  @override
  _PrerequisiteState createState() => _PrerequisiteState();
}

class _PrerequisiteState extends State<Prerequisite> {
  FirebaseStorage storage = FirebaseStorage.instance;
  var _extensionSet = MarkdownExtensionSet.githubFlavored;
  String? data;
  String? downloadURL;

  @override
  Widget build(BuildContext context) {
    final dp = isDisplayDesktop(context);
    final theme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).languageCode;
    Future<String?> getFiles() async {
      if (locale == 'ar') {
        data = 'intro_ar';
      } else if (locale == 'sw') {
        data = 'intro_sw';
      } else if (locale == 'id') {
        data = 'intro_id';
      } else {
        data = 'intro';
      }
      downloadURL = await storage.ref('prerequisites/${data}.md').getDownloadURL();
      await DownloadUtil.downloadFile(downloadURL!, 'preference');
      return downloadURL;
    }
    getFiles();
    return Scaffold(
      backgroundColor:
          context.isDarkMode ? null : Theme.of(context).primaryColorLight,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dp ? 30 : 1, vertical: 20),
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString(downloadURL!, cache: false),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  SizedBox(height: 30),
                  Consumer<SettingProvide>(
                    builder: (context, provide, child) {
                      return Expanded(
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
                                fontSize: dp ? provide.fontSize!+24 : 30,
                                letterSpacing: -3,
                                color: Color(0xff404040)),
                            h2: theme.headline6!.copyWith(
                                letterSpacing: .2,
                                decoration: TextDecoration.underline,
                                fontSize: dp ? provide.fontSize! +18 : provide.fontSize!+8,
                                fontWeight: FontWeight.w500),
                            p: theme.bodyText1!.copyWith(
                                fontWeight: FontWeight.w100,
                                height: dp ? 1.85 : 1.8,
                                fontSize: provide.fontSize),
                            blockquote: theme.bodyText1!.copyWith(
                                fontWeight: FontWeight.w100,
                                height: dp ? 1.85 : 1.8,
                                fontSize: provide.fontSize),
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
                      );
                    }
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
