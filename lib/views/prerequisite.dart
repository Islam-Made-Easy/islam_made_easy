import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:islam_made_easy/settings/settings_pro.dart';
import 'package:islam_made_easy/widgets/anim/load_indicator.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:provider/provider.dart';

import 'QnA/qna.dart';

class Prerequisite extends StatefulWidget {
  static const ROUTE_NAME = "/prerequisite";

  @override
  _PrerequisiteState createState() => _PrerequisiteState();
}

class _PrerequisiteState extends State<Prerequisite> {
  var _extensionSet = MarkdownExtensionSet.githubFlavored;
  late String data;
  late String url;
  late String api =
      'https://raw.githubusercontent.com/Islam-Made-Easy/ime-api/main/Assets/markdown/prerequisite';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dp = isDisplayDesktop(context);
    final theme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).languageCode;
    // todo: Load files to the local directory for offline access on desktop & mobile except for web
    Future<String> getDataFiles() async {
      if (locale == 'ar') {
        url = '${api}/intro_ar.md';
      } else if (locale == 'sw') {
        url = '${api}/intro_sw.md';
      } else if (locale == 'id') {
        url = '${api}/intro_id.md';
      } else {
        url = '${api}/intro.md';
      }
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return data = response.body;
      } else {
        return throw Exception("Failed to fetch Data");
      }
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dp ? 30 : 1, vertical: 20),
        child: FutureBuilder<String>(
          future: getDataFiles(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Consumer<SettingProvide>(builder: (context, provide, child) {
                    return Expanded(
                      child: Markdown(
                        key: Key(_extensionSet.name),
                        physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        data: snapshot.requireData,
                        extensionSet: _extensionSet.value,
                        listItemCrossAxisAlignment:
                            MarkdownListItemCrossAxisAlignment.start,
                        styleSheet: MarkdownStyleSheet(
                          h1Align: WrapAlignment.center,
                          h1: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: dp ? provide.fontSize! + 24 : 30,
                            letterSpacing: -3,
                            fontFamily: provide.fontType,
                            color: Color(0xff404040),
                          ),
                          h2: theme.titleLarge!.copyWith(
                            letterSpacing: .2,
                            decoration: TextDecoration.underline,
                            fontFamily: provide.fontType,
                            fontSize: dp
                                ? provide.fontSize! + 18
                                : provide.fontSize! + 8,
                            fontWeight: FontWeight.w500,
                          ),
                          p: theme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w100,
                            fontFamily: provide.fontType,
                            height: dp ? 1.85 : 1.8,
                            fontSize: provide.fontSize,
                          ),
                          blockquote: theme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w100,
                            height: dp ? 1.85 : 1.8,
                            fontFamily: provide.fontType,
                            fontSize: provide.fontSize,
                          ),
                          strong: theme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontFamily: provide.fontType,
                            height: dp ? 1.85 : 1.8,
                            fontSize: dp ? 17 : 15,
                          ),
                          blockSpacing: dp ? 25 : 10,
                          textScaleFactor: 1.0,
                        ),
                        selectable: true,
                        shrinkWrap: true,
                      ),
                    );
                  }),
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
