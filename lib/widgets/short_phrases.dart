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
      appBar: AppBar(
        title: Text(S.current.shortPhrasesT),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDesktop ? Colors.transparent : Theme.of(context).appBarTheme.color,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 20 : 0, vertical: isDesktop ? 50 : 0),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFAFAFC).withOpacity(0.2),
              border: Border.all(color: Theme.of(context).backgroundColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(0),
                bottomRight: Radius.elliptical(12, 200),
                bottomLeft: Radius.elliptical(90, 10),
              ),
            ),
            padding: EdgeInsets.all(isDesktop ? 42 : 10),
            child: Column(
              children: [
                _ShortW(
                    title: 'بسم الله الرحمان الرحيم',
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
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return WidgetAnimator(
      Stack(
        children: [
          Card(
            color: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.5, color: Theme.of(context).hoverColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ar ? 0 : 10),
                topRight: Radius.circular(ar ? 10 : 0),
                bottomRight:
                    ar ? Radius.elliptical(90, 10) : Radius.elliptical(12, 200),
                bottomLeft:
                    ar ? Radius.elliptical(12, 200) : Radius.elliptical(90, 10),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ListTile(
              title: Text(title),
              trailing: Text(trailing),
              subtitle: Text(subtitle),
              tileColor: Theme.of(context).hoverColor,
            ),
          ),
          Positioned(
            top: 15.0,
            left: ar ? 0 : null,
            right: ar ? null : 0,
            child: Container(
              height: 10.0,
              width: 40.0,
              decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).accentColor,
                      Theme.of(context).backgroundColor
                    ],
                    tileMode: TileMode.mirror,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.1, 1.0],
                  ),
                  shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
