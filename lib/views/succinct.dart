import 'package:islam_made_easy/settings/settings_pro.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/custom_selection_toolbar.dart';
import 'package:provider/provider.dart';

class Succinct extends StatefulWidget {
  static const ROUTE_NAME = "/succinct";

  @override
  _SuccinctState createState() => _SuccinctState();
}

class _SuccinctState extends State<Succinct> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double? proSize =
        Provider.of<SettingProvide>(context, listen: false).fontSize;
    String? proType =
        Provider.of<SettingProvide>(context, listen: false).fontType ?? 'Amiri';
    Function(TextSelection)? onSelectionChange;
    TextSelection textSelection = TextSelection.collapsed(offset: -1);
    final isDesktop = isDisplayDesktop(context);
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final bodyTextStyle = textTheme.bodyText1!.copyWith(
      fontFamily: proType,
      height: isDesktop ? 1.85 : 1.8,
      fontSize: isDesktop ? proSize! + 1 : proSize,
    );
    final bodyTextStyle2 =
        textTheme.headline5!.apply(fontFamily: 'Amiri', heightDelta: 2);
    final txtStyle = textTheme.headline6!.copyWith(
        fontFamily: proType,
        fontStyle: FontStyle.italic,
        decoration: TextDecoration.underline,
        fontSize: proSize! + 2,
        fontWeight: FontWeight.bold);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 30 : 1, vertical: 20),
          children: [
            SizedBox(height: 20),
            Center(
                child: SelectableText.rich(
              TextSpan(text: S.current.prerequisiteTitle),
              textAlign: TextAlign.center,
              selectionControls:
                  CustomTextSelectionControls(customButton: (start, end) {}),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * .06,
                  letterSpacing: -3,
                  fontFamily: 'Quicksand',
                  color: Color(0xff404040)),
            )),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SelectableText.rich(
                    TextSpan(text: S.current.basmallah),
                    onSelectionChanged: onSelectionChange?.call(textSelection),
                    selectionControls: CustomTextSelectionControls(),
                    style: TextStyle(
                        letterSpacing: .2,
                        fontSize: isDesktop ? 35 : 24,
                        fontWeight: FontWeight.w300),
                  ),
                  SelectableText(
                    S.current.succinctPar1,
                    selectionControls: CustomTextSelectionControls(),
                    style: bodyTextStyle,
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    S.current.succinctSubTitle1,
                    selectionControls: CustomTextSelectionControls(),
                    style: bodyTextStyle2,
                  ),
                  SelectableText(
                    S.current.succinctSub1Par1,
                    style: bodyTextStyle,
                  ),
                  SizedBox(height: 15),
                  SelectableText(
                    S.current.succinctSubTitle2,
                    style: bodyTextStyle2,
                  ),
                  SelectableText(
                    S.current.succinctSub2Par1,
                    style: bodyTextStyle,
                  ),
                  SelectableText(
                    S.current.succinctSubTitle3,
                    style: bodyTextStyle2,
                  ),
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
                  SelectableText(
                    S.current.succinctSubTitle4,
                    style: bodyTextStyle2,
                  ),
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
                  SelectableText(S.current.succinctSubTitle5,
                      style: bodyTextStyle2),
                  SelectableText(
                    S.current.succinctSub5Par1,
                    style: bodyTextStyle,
                  ),
                  SelectableText(S.current.succinctSubTitle6,
                      style: bodyTextStyle2),
                  SelectableText(
                    S.current.succinctSub6Par1,
                    style: bodyTextStyle,
                  ),
                  SelectableText(S.current.succinctSubTitle7,
                      style: bodyTextStyle2),
                  SelectableText(
                    S.current.succinctSub7Par1,
                    style: bodyTextStyle,
                  ),
                  SelectableText(S.current.succinctSubTitle8,
                      style: bodyTextStyle2),
                  SelectableText(S.current.succinctSub8Par1,
                      style: bodyTextStyle),
                  SelectableText(
                    S.current.succinctSubTitle9,
                    style: bodyTextStyle2,
                  ),
                  SelectableText(S.current.succinctSub9Par1,
                      style: bodyTextStyle),
                  SizedBox(height: 5),
                  SelectableText(S.current.succinctSub9Par2,
                      style: bodyTextStyle),
                  SelectableText(
                    S.current.succinctSubTitle10,
                    style: bodyTextStyle2,
                  ),
                  SelectableText(S.current.succinctSub10Par1,
                      style: bodyTextStyle),
                  SelectableText(
                    S.current.succinctSubTitle11,
                    style: bodyTextStyle2,
                  ),
                  SelectableText(S.current.succinctSub11Par1,
                      style: bodyTextStyle),
                  SelectableText(S.current.succinctSub11Par2,
                      style: bodyTextStyle),
                  SelectableText(
                    S.current.succinctSubTitle11a,
                    style: txtStyle,
                  ),
                  SelectableText(S.current.succinctSub11aPar1,
                      style: bodyTextStyle),
                  SizedBox(height: 5),
                  SelectableText(S.current.succinctSub11aPar2,
                      style: bodyTextStyle),
                  SelectableText(
                    S.current.succinctSubTitle11b,
                    style: txtStyle,
                  ),
                  SelectableText(S.current.succinctSub11bPar1,
                      style: bodyTextStyle),
                  SizedBox(height: 5),
                  SelectableText(S.current.succinctSub11bPar2,
                      style: bodyTextStyle),
                  SelectableText(
                    S.current.succinctSubTitle11c,
                    style: txtStyle,
                  ),
                  SelectableText(S.current.succinctSub11cPar1,
                      style: bodyTextStyle),
                  SelectableText(
                    S.current.succinctSubTitle11d,
                    style: txtStyle,
                  ),
                  SelectableText(S.current.succinctSub11dPar1,
                      style: bodyTextStyle),
                  SizedBox(height: 5),
                  SelectableText(S.current.succinctSub11dPar2,
                      style: bodyTextStyle),
                  SizedBox(height: 5),
                  SelectableText(S.current.succinctSub11dPar3,
                      style: bodyTextStyle),
                  SelectableText(
                    S.current.succinctSubTitle11e,
                    style: txtStyle,
                  ),
                  SelectableText(S.current.succinctSub11ePar1,
                      style: bodyTextStyle),
                  SizedBox(height: 5),
                  SelectableText(S.current.succinctSub11ePar2,
                      style: bodyTextStyle),
                  SizedBox(height: 5),
                  SelectableText(S.current.succinctSub11ePar3,
                      style: bodyTextStyle),
                  SelectableText(
                    S.current.succinctSubTitle11f,
                    style: txtStyle,
                  ),
                  SelectableText(S.current.succinctSub11fPar1,
                      style: bodyTextStyle),
                  SizedBox(height: 5),
                  SelectableText(S.current.succinctSub11fPar2,
                      style: bodyTextStyle),
                  SizedBox(height: 5),
                  SelectableText(S.current.succinctSub11fPar3,
                      style: bodyTextStyle),
                  SelectableText(
                    S.current.succinctSubTitle11g,
                    style: txtStyle,
                  ),
                  SelectableText(S.current.succinctSub11gPar1,
                      style: bodyTextStyle),
                  SizedBox(height: 5),
                  SelectableText(S.current.succinctSub11gPar2,
                      style: bodyTextStyle),
                  SizedBox(height: 5),
                  SelectableText(S.current.succinctSub11gPar3,
                      style: bodyTextStyle),
                  SelectableText(S.current.succinctSubTitle12,
                      style: bodyTextStyle2),
                  SelectableText(S.current.succinctSub12Par1,
                      style: bodyTextStyle),
                  SelectableText(S.current.succinctSubTitle13,
                      style: bodyTextStyle2),
                  SelectableText(S.current.succinctSub13Par1,
                      style: bodyTextStyle),
                  SelectableText(S.current.succinctSubTitle14,
                      style: bodyTextStyle2),
                  SelectableText(S.current.succinctSub14Par1,
                      style: bodyTextStyle),
                  SelectableText(S.current.succinctSubTitle14a,
                      style: bodyTextStyle2),
                  SelectableText(
                    S.current.succinctSub14aPar1,
                    style: bodyTextStyle,
                    textAlign: TextAlign.left,
                  ),
                  SelectableText(S.current.succinctSub14aPar2,
                      style: bodyTextStyle),
                  SelectableText(S.current.succinctSub14aPar3,
                      style: bodyTextStyle),
                  SelectableText(S.current.succinctSub14aPar4,
                      style: bodyTextStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
