import 'package:flutter/material.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/widgets/appBar.dart';
import 'package:islam_made_easy/widgets/infoCard.dart';
import 'package:islam_made_easy/widgets/viewText.dart';

class Fast extends StatefulWidget {
  @override
  _FastState createState() => _FastState();
}

class _FastState extends State<Fast> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: QnAppBar(title: S.current.swaum, isDesktop: isDesktop),
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 20 : 8,
            vertical: isDesktop ? 22 : 8,
          ),
          children: [
            InfoCard(
              quest: S.current.fastQ1,
              answers: [
                ViewText(data: S.current.fastA1par1),
                ViewText(data: S.current.fastA1par2),
                ViewText(data: S.current.fastA1par3),
                ViewText(data: S.current.fastA1par4),
              ],
            ),
            SizedBox(height: 10),
            InfoCard(
              quest: S.current.fastQ2,
              answers: [
                ViewText(data: S.current.fastA2par1),
                ViewText(data: S.current.fastA2par2),
                ViewText(data: S.current.fastA2par3),
                ViewText(data: S.current.fastA2par4),
                ViewText(data: S.current.fastA2par5),
                ViewText(data: S.current.fastA2par6),
                ViewText(data: S.current.fastA2par7),
              ],
            ),
            SizedBox(height: 10),
            InfoCard(quest: S.current.fastQ3, answers: [
              ViewText(data: S.current.fastA3par1),
              ViewText(data: S.current.fastA3par2),
            ]),
            SizedBox(height: 10),
            InfoCard(quest: S.current.fastQ4, answers: [
              ViewText(data: S.current.fastA4par1),
              ViewText(data: S.current.fastA4par2),
            ]),
            SizedBox(height: 10),
            InfoCard(quest: S.current.fastQ5, answers: [
              ViewText(data: S.current.fastA5par1),
              ViewText(data: S.current.fastA5par2),
            ]),
            SizedBox(height: 10),
            InfoCard(quest: S.current.fastQ6, answers: [
              ViewText(data: S.current.fastA6par1),
              ViewText(data: S.current.fastA6par2),
            ]),
            SizedBox(height: 10),
            InfoCard(quest: S.current.fastQ7, answers: [
              ViewText(data: S.current.fastA7Par1),
              ViewText(data: S.current.fastA7Par2),
              ViewText(data: S.current.fastA7Par3),
              ViewText(data: S.current.fastA7Par4),
            ]),
          ],
        ),
      ),
    );
  }
}
