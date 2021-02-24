import 'package:flutter/material.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/widgets/appBar.dart';
import 'package:islam_made_easy/widgets/detailsPage.dart';

class TawheedGK extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: QnAppBar(title: S.current.tawheed, isDesktop: isDesktop),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 50 : 10,
          vertical: isDesktop ? 20 : 10,
        ),
        children: [
          SizedBox(height: 10),
          OpenContainerWrapper(
            closedBuilder: (context, openContainer) => DetailsCard(
              openContainer: openContainer,
              title: S.current.nullifiersTitle,
              img: 'assets/images/hkm2.jpg',
            ),
            title: S.current.nullifiersTitle,
            data: [
              SelectableText(S.current.nullifiersIntro),
              SizedBox(height: 15),
              SelectableText(S.current.nullifiersPar1),
              SizedBox(height: 10),
              SelectableText(S.current.nullifiersPar2),
              SizedBox(height: 10),
              SelectableText(S.current.nullifiersPar3),
              SizedBox(height: 10),
              SelectableText(S.current.nullifiersPar4),
              SizedBox(height: 10),
              SelectableText(S.current.nullifiersPar5),
              SizedBox(height: 10),
              SelectableText(S.current.nullifiersPar6),
              SizedBox(height: 10),
              SelectableText(S.current.nullifiersPar7),
              SizedBox(height: 10),
              SelectableText(S.current.nullifiersPar8),
              SizedBox(height: 10),
              SelectableText(S.current.nullifiersPar9),
              SizedBox(height: 10),
              SelectableText(S.current.nullifiersPar10),
              SizedBox(height: 10),
              SelectableText(S.current.nullifiersPar11),
            ],
            barTitle: S.current.nullifiersTitle,
            image: 'assets/images/hkm.png',
          ),
          SizedBox(height: 10),
          OpenContainerWrapper(
            closedBuilder: (context, openContainer) => DetailsCard(
              openContainer: openContainer,
              title: S.current.monotheistTitle,
              img: 'assets/images/hrs1.jpg',
            ),
            title: S.current.monotheistTitle,
            data: [
              SelectableText(S.current.monotheistPar1),
              SizedBox(height: 15),
              SelectableText(S.current.monotheistPar2),
              SizedBox(height: 10),
              SelectableText(S.current.monotheistPar3),
              SizedBox(height: 10),
              SelectableText(S.current.monotheistPar4),
              SizedBox(height: 10),
              SelectableText(S.current.monotheistPar5),
              SizedBox(height: 10),
              SelectableText(S.current.monotheistPar6),
              SizedBox(height: 10),
              SelectableText(S.current.monotheistPar7),
              SizedBox(height: 10),
              SelectableText(S.current.monotheistPar8),
              SizedBox(height: 10),
              SelectableText(S.current.monotheistPar9),
              SizedBox(height: 10),
              SelectableText(S.current.monotheistPar10),
              SizedBox(height: 10),
              SelectableText(S.current.monotheistPar11),
              SizedBox(height: 10),
              SelectableText(S.current.monotheistPar12),
              SizedBox(height: 10),
              SelectableText(S.current.monotheistPar13),
              SizedBox(height: 10),
              SelectableText(S.current.monotheistPar14),
            ],
            barTitle: S.current.monotheistTitle,
            image: 'assets/images/hrs1.jpg',
          ),
          SizedBox(height: 10),
          OpenContainerWrapper(
            closedBuilder: (context, openContainer) => DetailsCard(
              openContainer: openContainer,
              title: S.current.assistTitle,
              img: 'assets/images/ist.jpg',
            ),
            title: S.current.assistTitle,
            data: [
              SelectableText(S.current.assistPar1),
              SizedBox(height: 10),
              SelectableText(S.current.assistPar2),
            ],
            barTitle: S.current.assistSubTitle,
            image: 'assets/images/ist.jpg',
          ),
        ],
      ),
    );
  }
}
