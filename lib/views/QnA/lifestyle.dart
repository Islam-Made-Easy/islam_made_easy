import 'package:flutter/material.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/widgets/appBar.dart';
import 'package:islam_made_easy/widgets/infoCard.dart';
import 'package:islam_made_easy/widgets/viewText.dart';

class Lifestyle extends StatefulWidget {
  @override
  _LifestyleState createState() => _LifestyleState();
}

class _LifestyleState extends State<Lifestyle> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: QnAppBar(title: S.current.lifestyle, isDesktop: isDesktop),
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 20 : 8,
            vertical: isDesktop ? 22 : 8,
          ),
          children: [
            SizedBox(height: 10),
            InfoCard(quest: S.current.lifestyleQ1, answers: [
               ViewText(data:S.current.lifestyleA1Par1),
               ViewText(data:S.current.lifestyleA1Par2),
            ]),
            SizedBox(height: 10),
            InfoCard(quest: S.current.lifestyleQ2, answers: [
               ViewText(data:S.current.lifestyleA2Par1),
            ]),
            SizedBox(height: 10),
            InfoCard(quest: S.current.hajjQ1, answers: [
               ViewText(data:S.current.hajjA1par1),
               ViewText(data:S.current.hajjA1par2),
               ViewText(data:S.current.hajjA1par3),
               ViewText(data:S.current.hajjA1par4),
               ViewText(data:S.current.hajjA1par5),
               ViewText(data:S.current.hajjA1par6),
               ViewText(data:S.current.hajjA1par7),
               ViewText(data:S.current.hajjA1par8),
               ViewText(data:S.current.hajjA1par9),
               ViewText(data:S.current.hajjA1par10),
               ViewText(data:S.current.hajjA1par11),
            ]),
            SizedBox(height: 10),
            InfoCard(quest: S.current.lifestyleQ3, answers: [
               ViewText(data:S.current.lifestyleA3Par1),
               ViewText(data:S.current.lifestyleA3Par2),
               ViewText(data:S.current.lifestyleA3Par3),
               ViewText(data:S.current.lifestyleA3Par4),
               ViewText(data:S.current.lifestyleA3Par5),
               ViewText(data:S.current.lifestyleA3Par6),
            ]),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
