import 'package:flutter/material.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/widgets/appBar.dart';

class HajjGeneralKnowledge extends StatefulWidget {
  @override
  _HajjGeneralKnowledgeState createState() => _HajjGeneralKnowledgeState();
}

class _HajjGeneralKnowledgeState extends State<HajjGeneralKnowledge> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      appBar: QnAppBar(title: S.current.hajj, isDesktop: isDesktop),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 50 : 10,
          vertical: isDesktop ? 20 : 10,
        ),
        children: [],
      ),
    );
  }
}
