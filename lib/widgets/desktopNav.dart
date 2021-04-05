import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grafpix/icons.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/views/QnA.dart';
import 'package:islam_made_easy/views/general_knowledge/general_knowlege.dart';
import 'package:islam_made_easy/views/prerequisite.dart';
import 'package:islam_made_easy/widgets/panels/mainPanel.dart';
import 'package:islam_made_easy/widgets/references.dart';
import 'package:islam_made_easy/widgets/short_phrases.dart';

import 'anim/ime_nav.dart';
import 'anim/shared_switcher.dart';
import 'navHeader.dart';

class DesktopNav extends StatefulWidget {
  const DesktopNav({this.extended});

  final bool extended;

  @override
  _DesktopNavState createState() => _DesktopNavState();
}

class _DesktopNavState extends State<DesktopNav>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> _isExtended;

  @override
  void initState() {
    super.initState();
    _isExtended = ValueNotifier<bool>(widget.extended);
  }

  int _selectedIndex = 0;
  List<Widget> screens = [
    MainPanel(),
    Prerequisite(),
    QnA(),
    GeneralKnowledge(),
    References(),
    ShortPhrases()
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LayoutBuilder(builder: (context, constraints) {
          return Container(
            color: Theme.of(context).navigationRailTheme.backgroundColor,
            child: SingleChildScrollView(
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: ValueListenableBuilder<bool>(
                      valueListenable: _isExtended,
                      builder: (context, value, child) {
                        return NavigationRail(
                          destinations: [
                            NavigationRailDestination(
                              icon: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.zero,
                                  child: FaIcon(PixIcon.fab_quora)),
                              label: Text(S.current.quiz),
                            ),
                            NavigationRailDestination(
                              icon: Material(
                                  color: Colors.transparent,
                                  child: FaIcon(PixIcon.typcn_document_text)),
                              label: Text(S.current.prerequisite),
                            ),
                            NavigationRailDestination(
                              icon: Material(
                                  color: Colors.transparent,
                                  child: FaIcon(PixIcon.fab_quinscape)),
                              label: Text(S.current.questionsAndAnswers),
                            ),
                            NavigationRailDestination(
                              icon: Material(
                                  color: Colors.transparent,
                                  child: FaIcon(PixIcon.pix_book)),
                              label: Text(S.current.generalKnowledge),
                            ),
                            NavigationRailDestination(
                              icon: Material(
                                  color: Colors.transparent,
                                  child: FaIcon(PixIcon.fa_scroll)),
                              label: Text(S.current.references),
                            ),
                            NavigationRailDestination(
                              icon: Material(
                                  color: Colors.transparent,
                                  child: FaIcon(PixIcon.fab_ussunnah)),
                              label: Text(S.current.shortPhrases),
                            ),
                          ],
                          extended: _isExtended.value,
                          selectedIndex: _selectedIndex,
                          labelType: NavigationRailLabelType.none,
                          backgroundColor: Color(0xFFF2F2F2),
                          leading: NavigationRailHeader(extended: _isExtended),
                          onDestinationSelected: (index) {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          // groupAlignment: 1.0,
                        );
                      }),
                ),
              ),
            ),
          );
        }),
        const VerticalDivider(
          thickness: 1,
          width: 1,
          color: Color(0xFFF2F2F2),
        ),
        Expanded(
          child: SharedAxisTransitionSwitcher(
            child: IMENav(child: screens[_selectedIndex]),
          ),
        )
      ],
    );
  }
}
