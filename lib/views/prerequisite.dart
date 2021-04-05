import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:markdown/markdown.dart' as md;

class Prerequisite extends StatefulWidget implements MarkdownDemoWidget {
  @override
  _PrerequisiteState createState() => _PrerequisiteState();

  @override
  Future<String> get data async =>
      await rootBundle.loadString('assets/md/intro.md');
}

class _PrerequisiteState extends State<Prerequisite> {
  var _extensionSet = MarkdownExtensionSet.githubFlavored;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      body: Scrollbar(
        controller: controller,
        showTrackOnHover: true,
        isAlwaysShown: true,
        child: FutureBuilder(
          future: widget.data,
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
                      styleSheet: MarkdownStyleSheet(
                        h1: Theme
                            .of(context)
                            .textTheme
                            .headline1
                            .copyWith(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        p: Theme
                            .of(context)
                            .textTheme
                            .bodyText1,
                      ),
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
    );
  }

  void linkOnTapHandler(BuildContext context, String text, String href,
      String title) async {
    showDialog(
      context: context,
      builder: (context) => _createDialog(context, text, href, title),
    );
  }

  Widget _createDialog(BuildContext context, String text, String href,
      String title) =>
      AlertDialog(
        title: Text('Reference Link'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(
                'See the following link for more information:',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,
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

abstract class MarkdownDemoWidget extends Widget {
  Future<String> get data;
}

enum MarkdownExtensionSet { none, commonMark, githubFlavored, githubWeb }

extension MarkdownExtensionSetExtension on MarkdownExtensionSet {
  String get name => describeEnum(this);

  String get displayTitle =>
          () {
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

  md.ExtensionSet get value =>
          () {
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

  String get displayTitle =>
          () {
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
