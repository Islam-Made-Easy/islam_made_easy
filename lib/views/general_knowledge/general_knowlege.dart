import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/widgets/appBar.dart';
import 'package:islam_made_easy/widgets/detailsPage.dart';
import 'package:islam_made_easy/widgets/viewText.dart';

class GeneralKnowledge extends StatefulWidget {
  static const ROUTE_NAME = "/general";

  @override
  _GeneralKnowledgeState createState() => _GeneralKnowledgeState();
}

class _GeneralKnowledgeState extends State<GeneralKnowledge> {
  EasyRefreshController _controller;

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: QnAppBar(title: S.current.generalKnowledge, isDesktop: isDesktop),
      backgroundColor: theme.backgroundColor,
      body: EasyRefresh(
        controller: _controller,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 50 : 15,
            vertical: isDesktop ? 20 : 10,
          ),
          children: [
            OpenContainerWrapper(
              closedBuilder: (context, openContainer) => DetailsCard(
                openContainer: openContainer,
                title: S.current.tawheed,
                img: 'assets/images/sun.jpg',
              ),
              title: S.current.tawheed,
              data: [
                SizedBox(height: 20),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.nullifiersTitle,
                    img: 'assets/images/hkm2.jpg',
                  ),
                  title: S.current.nullifiersTitle,
                  data: [
                    ViewText(data: S.current.nullifiersIntro),
                    SizedBox(height: 15),
                    ViewText(data: S.current.nullifiersPar1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.nullifiersPar2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.nullifiersPar3),
                    ViewText(data: S.current.nullifiersPar4),
                    SizedBox(height: 10),
                    ViewText(data: S.current.nullifiersPar5),
                    SizedBox(height: 10),
                    ViewText(data: S.current.nullifiersPar6),
                    SizedBox(height: 10),
                    ViewText(data: S.current.nullifiersPar7),
                    SizedBox(height: 10),
                    ViewText(data: S.current.nullifiersPar8),
                    SizedBox(height: 10),
                    ViewText(data: S.current.nullifiersPar9),
                    SizedBox(height: 10),
                    ViewText(data: S.current.nullifiersPar10),
                    SizedBox(height: 10),
                    ViewText(data: S.current.nullifiersPar11),
                  ],
                  barTitle: S.current.nullifiersTitle,
                  image: 'assets/images/hkm.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 50),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.monotheistTitle,
                    img: 'assets/images/hrs1.jpg',
                  ),
                  title: S.current.monotheistTitle,
                  data: [
                    ViewText(data: S.current.monotheistPar1),
                    SizedBox(height: 15),
                    ViewText(data: S.current.monotheistPar2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.monotheistPar3),
                    SizedBox(height: 10),
                    ViewText(data: S.current.monotheistPar4),
                    SizedBox(height: 10),
                    ViewText(data: S.current.monotheistPar5),
                    SizedBox(height: 10),
                    ViewText(data: S.current.monotheistPar6),
                    SizedBox(height: 10),
                    ViewText(data: S.current.monotheistPar7),
                    SizedBox(height: 10),
                    ViewText(data: S.current.monotheistPar8),
                    SizedBox(height: 10),
                    ViewText(data: S.current.monotheistPar9),
                    SizedBox(height: 10),
                    ViewText(data: S.current.monotheistPar10),
                    SizedBox(height: 10),
                    ViewText(data: S.current.monotheistPar11),
                    SizedBox(height: 10),
                    ViewText(data: S.current.monotheistPar12),
                    SizedBox(height: 10),
                    ViewText(data: S.current.monotheistPar13),
                    SizedBox(height: 10),
                    ViewText(data: S.current.monotheistPar14),
                  ],
                  barTitle: S.current.monotheistTitle,
                  image: 'assets/images/hrs1.jpg',
                ),
                Divider(endIndent: 40, indent: 40, height: 50),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.assistTitle,
                    img: 'assets/images/ist.jpg',
                  ),
                  title: S.current.assistTitle,
                  data: [
                    ViewText(data: S.current.assistPar1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.assistPar2),
                  ],
                  barTitle: S.current.assistSubTitle,
                  image: 'assets/images/ist.jpg',
                ),
                Divider(
                  endIndent: 40,
                  indent: 40,
                  height: 60,
                ),
              ],
              barTitle: S.current.tawheed,
              image: 'assets/images/sun.jpg',
            ),
            Divider(endIndent: 40, indent: 40, height: 50),
            OpenContainerWrapper(
              closedBuilder: (context, openContainer) => DetailsCard(
                openContainer: openContainer,
                title: S.current.prayerTitles,
                img: 'assets/images/wter.jpg',
              ),
              title: S.current.prayerTitles,
              data: [
                SizedBox(height: 20),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.prayerConditionsTitle,
                    img: 'assets/images/msd.jpg',
                  ),
                  title: S.current.prayerConditionsTitle,
                  data: [
                    ViewText(data: S.current.prayerConditionsPar1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar3),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar4),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar5),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar6),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar7),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar8),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar9),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar10),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar11),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar12),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar13),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar14),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerConditionsPar15),
                  ],
                  barTitle: S.current.swalah,
                  image: 'assets/images/msd2.jpg',
                ),
                Divider(endIndent: 40, indent: 40, height: 50),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) {
                    return DetailsCard(
                      openContainer: openContainer,
                      title: S.current.prayerPillarsTitle,
                      img: 'assets/images/time.jpg',
                    );
                  },
                  title: S.current.prayerPillarsTitle,
                  data: [
                    ViewText(data: S.current.prayerPillarsPar1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar3),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar4),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar5),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar6),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar7),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar8),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar9),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar10),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar11),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar12),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar13),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar14),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar15),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar16),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar17),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar18),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar19),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar20),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar21),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerPillarsPar22),
                  ],
                  barTitle: S.current.swalah,
                  image: 'assets/images/rose.jpg',
                ),
                Divider(endIndent: 40, indent: 40, height: 50),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) {
                    return DetailsCard(
                      openContainer: openContainer,
                      title: S.current.prayerRequirementsTitle,
                      img: 'assets/images/sln.jpg',
                    );
                  },
                  title: S.current.prayerRequirementsTitle,
                  data: [
                    ViewText(data: S.current.prayerRequirementsPar1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.prayerRequirementsPar2),
                  ],
                  barTitle: S.current.swalah,
                  image: 'assets/images/sky.jpg',
                ),
                Divider(
                  endIndent: 40,
                  indent: 40,
                  height: 60,
                ),
              ],
              barTitle: S.current.swalah,
              image: 'assets/images/wtr.jpg',
            ),
            Divider(endIndent: 40, indent: 40, height: 50),
            OpenContainerWrapper(
              closedBuilder: (context, openContainer) => DetailsCard(
                openContainer: openContainer,
                title: S.current.fastBreakTitle,
                img: 'assets/images/flw.jpg',
              ),
              title: S.current.fastBreakTitle,
              data: [
                ViewText(
                    data: S.current.fastBreakPar1(
                        '‫ذهب‬ ‫الظمأ‬ ‫وابتلت‬ ‫العروق‬ ‫وثبت‬ ‫األجر‬ ‫إن شاء الله‬')),
                ViewText(data: S.current.fastBreakPar2),
                ViewText(data: S.current.fastBreakPar3),
                ViewText(
                    data: S.current.fastBreakPar4(
                  'اللهم لك صمنا و على رزقك أفطرنا',
                )),
                ViewText(data: S.current.fastBreakPar5),
              ],
              barTitle: S.current.fastBreakSubTitle,
              image: 'assets/images/flw.jpg',
            ),
            Divider(endIndent: 40, indent: 40, height: 50),

            /// ---------------------------------------Hajj--------------------///
            OpenContainerWrapper(
              closedBuilder: (context, openContainer) => DetailsCard(
                openContainer: openContainer,
                title: S.current.hajjTitle,
                img: 'assets/images/hajj.png',
              ),
              title: S.current.hajjTitle,
              data: [
                SizedBox(height: 20),
                SelectableText(S.current.basmallah,
                    style: TextStyle(fontSize: 30)),
                SelectableText(S.current.hajjPar1,
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Card(
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(
                        horizontal: Platform.isLinux ? 10 : 8,
                        vertical: Platform.isLinux ? 22 : 8),
                    title: Text(
                      S.current.hajjSubTitle1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                    childrenPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    children: [
                      ViewText(data: S.current.hajjSub1Par1),
                      ViewText(data: S.current.hajjSub1Par2),
                      ViewText(data: S.current.hajjSub1Par3),
                      ViewText(data: S.current.hajjSub1Par4),
                    ],
                  ),
                ),
                Divider(endIndent: 40, indent: 40, height: 50),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle2,
                    img: 'assets/images/hajj1.jpg',
                  ),
                  title: S.current.hajjSubTitle2,
                  data: [
                    ViewText(data: S.current.hajjSub2Par1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub2Par2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub2Par3),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/hajj1.jpg',
                ),
                Divider(endIndent: 40, indent: 40, height: 50),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle3,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle3,
                  data: [
                    ViewText(data: S.current.hajjSub3Par1),
                    SizedBox(height: 10),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 50),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle4,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle4,
                  data: [
                    ViewText(data: S.current.hajjSub4Par1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub4Par2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub4Par3),
                    SizedBox(height: 10),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 50),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle5,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle5,
                  data: [
                    ViewText(data: S.current.hajjSub5Par1),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 50),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle6,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle6,
                  data: [
                    ViewText(data: S.current.hajjSub6Par1),
                    ViewText(data: S.current.hajjSub6Par2),
                    ViewText(data: S.current.hajjSub6Par3),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColorDark),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ViewText(data: S.current.hajjSubTitle6a),
                          ViewText(data: S.current.hajjSub6aPar1),
                        ],
                      ),
                    )
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle7,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle7,
                  data: [
                    ViewText(data: S.current.hajjSub7Par1),
                    ViewText(data: S.current.hajjSub7Par2),
                    SelectableText(
                      S.current.hajjSub7Par2Dua,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: isDesktop ? 40 : 26),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColorDark),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SelectableText(
                            S.current.hajjSub7Par3,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle8,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle8,
                  data: [
                    ViewText(data: S.current.hajjSub8Par1),
                    SelectableText(
                      S.current.hajjSub8Par2Dua,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColorDark),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SelectableText(
                            S.current.hajjSub8Par2,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 50),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle9,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle9,
                  data: [
                    ViewText(data: S.current.hajjSub9Par1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub9Par2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub9Par3),
                    ViewText(data: S.current.hajjSub9Par4),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub9Par5),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub9Par6),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle10,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle10,
                  data: [
                    ViewText(data: S.current.hajjSub10Par1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub10Par2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub10Par3),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub10Par4),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle11,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle11,
                  data: [
                    ViewText(data: S.current.hajjSub11Par1),
                    SelectableText(
                      S.current.hajjSub11Par1Dua,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColorDark),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SelectableText(
                            S.current.hajjSub11Par2,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub11Par3),
                    ViewText(data: S.current.hajjSub11Par4),
                    ViewText(data: S.current.hajjSub11Par5),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle12,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle12,
                  data: [
                    ViewText(data: S.current.hajjSub12Par1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub12Par2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub12Par3),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle13,
                    img: 'assets/images/Jamarat.jpg',
                  ),
                  title: S.current.hajjSubTitle13,
                  data: [
                    ViewText(data: S.current.hajjSub13Par1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub13Par2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub13Par3),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub13Par4),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub13Par5),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub13Par6),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub13Par7),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub13Par8),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Jamarat.jpg',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle14,
                    img:  'assets/images/thwaf.jpg',
                  ),
                  title: S.current.hajjSubTitle14,
                  data: [
                    ViewText(data: S.current.hajjSub14Par1),
                    ViewText(data: S.current.hajjSub14Par2),
                    ViewText(data: S.current.hajjSub14Par3),
                    SelectableText(
                      S.current.hajjSub14Par3Aya,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColorDark),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SelectableText(
                            S.current.hajjSub14Par4,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub14Par5),
                    ViewText(data: S.current.hajjSub14Par6),
                    ViewText(data: S.current.hajjSub14Par7),
                    ViewText(data: S.current.hajjSub14Par8),
                    ViewText(data: S.current.hajjSub14Par9),
                    ViewText(data: S.current.hajjSub14Par10),
                    ViewText(data: S.current.hajjSub14Par11),
                    ViewText(data: S.current.hajjSub14Par12),
                    ViewText(data: S.current.hajjSub14Par13),
                  ],
                  barTitle: S.current.hajj,
                  image:  'assets/images/thwaf.jpg',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle15,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle15,
                  data: [
                    ViewText(data: S.current.hajjSub15Par1),
                    SelectableText(
                      S.current.hajjSub15Par1Aya,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub15Par2),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColorDark),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SelectableText(
                            S.current.hajjSub15Par2Dua,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub15Par3),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub15Par4),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub15Par5),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle16,
                    img: 'assets/images/thwaf.jpg',
                  ),
                  title: S.current.hajjSubTitle16,
                  data: [
                    ViewText(data: S.current.hajjSub16Par1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub16Par2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub16Par3),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/thwaf.jpg',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle17,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle17,
                  data: [
                    ViewText(data: S.current.hajjSub17Par1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub17Par2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub17Par3),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub17Par4),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub17Par5),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle18,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle18,
                  data: [
                    ViewText(data: S.current.hajjSub18Par1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub18Par2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub18Par3),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) => DetailsCard(
                    openContainer: openContainer,
                    title: S.current.hajjSubTitle19,
                    img: 'assets/images/Hajj.png',
                  ),
                  title: S.current.hajjSubTitle19,
                  data: [
                    ViewText(data: S.current.hajjSub19Par1),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub19Par2),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub19Par3),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub19Par4),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub19Par5),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub19Par6),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub19Par7),
                    SizedBox(height: 10),
                    ViewText(data: S.current.hajjSub19Par8),
                    SelectableText(
                      S.current.hajjSub19Par9,
                      style: TextStyle(
                          fontSize: 22, color: Theme.of(context).accentColor),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                  barTitle: S.current.hajj,
                  image: 'assets/images/Hajj.png',
                ),
                Divider(endIndent: 40, indent: 40, height: 60),
              ],
              barTitle: S.current.hajj,
              image: 'assets/images/hajj.png',
            ),
            Divider(endIndent: 40, indent: 40, height: 50),
            //--------------------------------------------------------------------------------------//
            OpenContainerWrapper(
              closedBuilder: (context, openContainer) => DetailsCard(
                openContainer: openContainer,
                title: S.current.eatingNotesTitle,
                img: 'assets/images/fish.jpg',
              ),
              title: S.current.eatingNotesTitle,
              data: [
                ViewText(data: S.current.eatingNotesPar1),
                SizedBox(height: 10),
                ViewText(data: S.current.eatingNotesPar2),
                SizedBox(height: 10),
                ViewText(data: S.current.eatingNotesPar3),
                SizedBox(height: 10),
                ViewText(data: S.current.eatingNotesPar4),
              ],
              barTitle: S.current.eatingMeatTitle,
              image: 'assets/images/fish.jpg',
            ),
            Divider(endIndent: 40, indent: 40, height: 50),
            OpenContainerWrapper(
              closedBuilder: (context, openContainer) {
                return DetailsCard(
                  openContainer: openContainer,
                  img: 'assets/images/sun2.jpg',
                  title: S.current.usuryTitle,
                );
              },
              title: S.current.usuryTitle,
              data: [
                ViewText(data: S.current.usuryPar1),
                SizedBox(height: 10),
                ViewText(data: S.current.usuryPar2),
                SizedBox(height: 10),
                ViewText(data: S.current.usuryPar3),
                SizedBox(height: 10),
                ViewText(data: S.current.usuryPar4),
                SizedBox(height: 10),
                ViewText(data: S.current.usuryPar5),
                SizedBox(height: 10),
                ViewText(data: S.current.usuryPar6),
                SizedBox(height: 10),
                ViewText(data: S.current.usuryPar7),
              ],
              barTitle: S.current.fabricated,
              image: 'assets/images/sun2.jpg',
            ),
            Divider(endIndent: 40, indent: 40, height: 50),
            OpenContainerWrapper(
              closedBuilder: (context, openContainer) => DetailsCard(
                openContainer: openContainer,
                title: S.current.enteringMosqueTitle,
                img: 'assets/images/flw1.jpg',
              ),
              title: S.current.enteringMosqueTitle,
              data: [
                ViewText(data: S.current.enteringMosquePar1),
                SizedBox(height: 10),
                ViewText(data: S.current.enteringMosquePar2),
                SizedBox(height: 10),
                ViewText(data: S.current.enteringMosquePar3),
                SizedBox(height: 10),
                ViewText(data: S.current.enteringMosquePar4),
              ],
              barTitle: S.current.enteringMosqueSubTitle,
              image: 'assets/images/flw1.jpg',
            ),
          ],
        ),
      ),
    );
  }
}
