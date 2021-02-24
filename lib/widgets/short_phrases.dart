import 'package:flutter/material.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';

import 'anim/anim.dart';

class ShortPhrases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 20 : 0, vertical: isDesktop ? 50 : 0),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFAFAFC).withOpacity(0.2),
              border: Border.all(color: Theme.of(context).backgroundColor),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(isDesktop ? 42 : 10),
            child: Column(
              children: [
                AppBar(
                  title: Text(S.current.shortPhrasesT),
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                _ShortW(
                    title: ' بســـم اللــه الرحــمــن الـرحـــيــم',
                    subtitle: S.current.basmallah,
                    trailing: '(​ Bismilahi Rahmani Raheem )'),
                _ShortW(
                    title: 'سبحانه وتعالى',
                    subtitle: 'The Praised and Exalted',
                    trailing: '(​ subhanna wa ta‘ala )'),
                _ShortW(
                    title: 'السلام عليكم',
                    subtitle: 'May the Peace be upon you',
                    trailing: 'Assalam alaykum'),
                _ShortW(
                    title: 'ﷺ / ‫صلى الله عليه وسلم',
                    subtitle: 'Peace and blessings of Allah be upon him',
                    trailing: '(​ sallallahu ‘alayhi wa sallam ​ )'),
                _ShortW(
                    title: 'عليه‬ السالم‬',
                    subtitle: 'Peace be upon him',
                    trailing: '(​ ‘alayhis-salam ​ )'),
                _ShortW(
                    title: 'رضي الله عنه',
                    subtitle: 'May Allah be pleased with him',
                    trailing: '(​ radiyallahu ‘anhu ​ )'),
                _ShortW(
                    title: 'رضي الله عنها‬',
                    subtitle: 'May Allah be pleased with her',
                    trailing: '(​ radiyallahu ‘anha ​ )'),
                _ShortW(
                    title: 'رضي الله عنهما',
                    subtitle: 'May Allah be pleased with both',
                    trailing: '(​ radiyallahu ‘anhumaa ​ )'),
                _ShortW(
                    title: 'رضي الله عنهم',
                    subtitle: 'May Allah be pleased with them',
                    trailing: '(​ radiyallahu ‘anhum​ )'),
                _ShortW(
                    title: 'رحمه الله',
                    subtitle: 'May Allah have mercy on him',
                    trailing: '(​ rahimahullāh )'),
                _ShortW(
                    title: 'حفظه الله',
                    subtitle: 'May Allah Preserve him',
                    trailing: '(​ hafidhahullah )'),
                _ShortW(
                    title: 'و الله أعلم',
                    subtitle: 'And Allah knows best',
                    trailing: '(​ wallahu a`alam )'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShortW extends StatelessWidget {
  final String title;
  final String subtitle;
  final String trailing;

  const _ShortW({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      Card(
        color: Colors.transparent,
        elevation: 0,
        child: ListTile(
          title: Text(title),
          trailing: Text(trailing),
          subtitle: Text(subtitle),
          tileColor: Theme.of(context).hoverColor,
        ),
      ),
    );
  }
}
