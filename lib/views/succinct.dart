import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';

class Succinct extends StatefulWidget {
  static const ROUTE_NAME = "/succinct";

  @override
  _SuccinctState createState() => _SuccinctState();
}

class _SuccinctState extends State<Succinct> {
  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final isDesktop = isDisplayDesktop(context);
    final textTheme = Theme.of(context).textTheme;
    final bodyTextStyle =
        textTheme.bodyText1.apply(fontFamily: 'Amiri', heightDelta: 1.8);
    final bodyTextStyle2 =
        textTheme.headline5.apply(fontFamily: 'Amiri', heightDelta: 1.8);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Scrollbar(
        showTrackOnHover: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 30 : 1, vertical: 20),
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Center(
                    child: SelectableText(
                  S.current.prerequisiteTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: isDesktop ? 30 : 20,
                      // color: Color(0xffC19C4D),
                      fontFamily: 'Quattrocento'),
                )),
                leading: isDesktop
                    ? null
                    : IconButton(
                  icon: FaIcon(locale.languageCode == 'ar'
                      ? FontAwesomeIcons.angleRight
                      : FontAwesomeIcons.angleLeft),
                  onPressed: Get.back,
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                ),
              ),
              SizedBox(height: 10),
              Card(
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SelectableText(
                        S.current.basmallah,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 30,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        S.current.succinctPar1,
                        style: bodyTextStyle,
                      ),
                      SizedBox(height: 20),
                      SelectableText(
                        S.current.succinctSubTitle1,
                        style: bodyTextStyle2,
                      ),
                      SizedBox(height: 8),
                      SelectableText(
                        S.current.succinctSub1Par1,
                        style: bodyTextStyle,
                      ),
                      SizedBox(height: 15),
                      SelectableText(
                        S.current.succinctSubTitle2,
                        style: bodyTextStyle2,
                      ),
                      SizedBox(height: 8),
                      SelectableText(
                        S.current.succinctSub2Par1,
                        style: bodyTextStyle,
                      ),
                      SizedBox(height: 18),
                      SelectableText(
                        S.current.succinctSubTitle3,
                        style: bodyTextStyle2,
                      ),
                      SizedBox(height: 8),
                      SelectableText(
                        S.of(context).succinctSub3Par1(
                              'رب زدني علما',
                              ' سبحانك ﻻ علم لنا إﻻ ما علمتنا إنك أنت العلىم الحكىم ',
                              'اللهم علمني ما ينفعن . و انفعني بما علمتني ',
                              'اللهم فقهني في الدين وعلمني التاويل',
                              'اللهم يا معلم آدم وابراهيم علمني و يا مفهم سليمان فهمني ',
                            ),
                        style: bodyTextStyle,
                      ),
                      SizedBox(height: 18),
                      SelectableText(
                        S.current.succinctSubTitle4,
                        style: bodyTextStyle2,
                      ),
                      SizedBox(height: 8),
                      SelectableText(
                        S.current.succinctSub4Par1,
                        style: bodyTextStyle,
                      ),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub4Par2,
                          style: bodyTextStyle),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub4Par3,
                          style: bodyTextStyle),
                      SizedBox(height: 18),
                      SelectableText(S.current.succinctSubTitle5,
                          style: bodyTextStyle2),
                      SizedBox(height: 8),
                      SelectableText(
                        S.current.succinctSub5Par1,
                        style: bodyTextStyle,
                      ),
                      SizedBox(height: 18),
                      SelectableText(S.current.succinctSubTitle6,
                          style: bodyTextStyle2),
                      SelectableText(
                        S.current.succinctSub6Par1,
                        style: bodyTextStyle,
                      ),
                      SizedBox(height: 18),
                      SelectableText(S.current.succinctSubTitle7,
                          style: bodyTextStyle2),
                      SizedBox(height: 8),
                      SelectableText(
                        S.current.succinctSub7Par1,
                        style: bodyTextStyle,
                      ),
                      SizedBox(height: 18),
                      SelectableText(S.current.succinctSubTitle8,
                          style: bodyTextStyle2),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSub8Par1,
                          style: bodyTextStyle),
                      SizedBox(height: 18),
                      SelectableText(
                        S.current.succinctSubTitle9,
                        style: bodyTextStyle2,
                      ),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSub9Par1,
                          style: bodyTextStyle),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub9Par2,
                          style: bodyTextStyle),
                      SizedBox(height: 18),
                      SelectableText(
                        S.current.succinctSubTitle10,
                        style: bodyTextStyle2,
                      ),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSub10Par1,
                          style: bodyTextStyle),
                      SizedBox(height: 18),
                      SelectableText(
                        S.current.succinctSubTitle11,
                        style: bodyTextStyle2,
                      ),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSub11Par1,
                          style: bodyTextStyle),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSub11Par2,
                          style: bodyTextStyle),
                      SizedBox(height: 8),
                      SelectableText(
                        S.current.succinctSubTitle11a,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSub11aPar1,
                          style: bodyTextStyle),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub11aPar2,
                          style: bodyTextStyle),
                      SizedBox(height: 10),
                      SelectableText(
                        S.current.succinctSubTitle11b,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SelectableText(S.current.succinctSub11bPar1,
                          style: bodyTextStyle),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub11bPar2,
                          style: bodyTextStyle),
                      SizedBox(height: 10),
                      SelectableText(
                        S.current.succinctSubTitle11c,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SelectableText(S.current.succinctSub11cPar1,
                          style: bodyTextStyle),
                      SizedBox(height: 10),
                      SelectableText(
                        S.current.succinctSubTitle11d,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SelectableText(S.current.succinctSub11dPar1,
                          style: bodyTextStyle),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub11dPar2,
                          style: bodyTextStyle),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub11dPar3,
                          style: bodyTextStyle),
                      SizedBox(height: 10),
                      SelectableText(
                        S.current.succinctSubTitle11e,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SelectableText(S.current.succinctSub11ePar1,
                          style: bodyTextStyle),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub11ePar2,
                          style: bodyTextStyle),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub11ePar3,
                          style: bodyTextStyle),
                      SizedBox(height: 10),
                      SelectableText(
                        S.current.succinctSubTitle11f,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SelectableText(S.current.succinctSub11fPar1,
                          style: bodyTextStyle),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub11fPar2,
                          style: bodyTextStyle),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub11fPar3,
                          style: bodyTextStyle),
                      SizedBox(height: 10),
                      SelectableText(
                        S.current.succinctSubTitle11g,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SelectableText(S.current.succinctSub11gPar1,
                          style: bodyTextStyle),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub11gPar2,
                          style: bodyTextStyle),
                      SizedBox(height: 5),
                      SelectableText(S.current.succinctSub11gPar3,
                          style: bodyTextStyle),
                      SizedBox(height: 18),
                      SelectableText(S.current.succinctSubTitle12,
                          style: bodyTextStyle2),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSub12Par1,
                          style: bodyTextStyle),
                      SizedBox(height: 18),
                      SelectableText(S.current.succinctSubTitle13,
                          style: bodyTextStyle2),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSub13Par1,
                          style: bodyTextStyle),
                      SizedBox(height: 18),
                      SelectableText(S.current.succinctSubTitle14,
                          style: bodyTextStyle2),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSub14Par1,
                          style: bodyTextStyle),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSubTitle14a,
                          style: bodyTextStyle2),
                      SizedBox(height: 8),
                      SelectableText(
                        S.current.succinctSub14aPar1,
                        style: bodyTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSub14aPar2,
                          style: bodyTextStyle),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSub14aPar3,
                          style: bodyTextStyle),
                      SizedBox(height: 8),
                      SelectableText(S.current.succinctSub14aPar4,
                          style: bodyTextStyle),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
