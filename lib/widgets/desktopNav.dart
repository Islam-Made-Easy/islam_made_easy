import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:coachmaker/coachmaker.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/anim/ime_nav.dart';
import 'package:islam_made_easy/widgets/anim/shared_switcher.dart';
import 'package:islam_made_easy/widgets/navHeader.dart';
import 'package:islam_made_easy/widgets/popup_menu.dart';

import 'buttons/custom_icon_button.dart';

class DesktopNav extends StatefulWidget {
  const DesktopNav({this.extended});

  final bool? extended;

  @override
  _DesktopNavState createState() => _DesktopNavState();
}

class _DesktopNavState extends State<DesktopNav>
    with SingleTickerProviderStateMixin {
  late ValueNotifier<bool?> _isExtended;

  @override
  void initState() {
    super.initState();
    _isExtended = ValueNotifier<bool?>(widget.extended);
  }

  int _selectedIndex = 0;
  List<Widget> screens = [
    MainPanel(),
    Prerequisite(),
    Succinct(),
    QnA(),
    GeneralKnowledge(),
    References(),
    ShortPhrases()
  ];
  static DelayUI delay = DelayUI(Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    final theme = Theme.of(context);
    final text = theme.textTheme.labelLarge!.copyWith(fontFamily: 'Quicksand');
    final transparent = Colors.transparent;
    return CallbackShortcuts(
      bindings: {
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.alt):
            coachMaker
      },
      child: Row(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return Container(
              color: theme.navigationRailTheme.backgroundColor,
              child: SingleChildScrollView(
                clipBehavior: Clip.antiAlias,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: ValueListenableBuilder<bool?>(
                        valueListenable: _isExtended,
                        builder: (context, value, child) {
                          return NavigationRail(
                            destinations: [
                              NavigationRailDestination(
                                icon: CoachPoint(
                                  initial: '1',
                                  child: Material(
                                    color: transparent,
                                    borderRadius: BorderRadius.zero,
                                    child: Icon(FontAwesomeIcons.quora),
                                  ),
                                ),
                                label: Text(S.current.quiz, style: text),
                              ),
                              NavigationRailDestination(
                                icon: CoachPoint(
                                  initial: '2',
                                  child: Material(
                                    color: transparent,
                                    child: Icon(FontAwesomeIcons.fileAlt),
                                  ),
                                ),
                                label:
                                    Text(S.current.prerequisite, style: text),
                              ),
                              NavigationRailDestination(
                                icon: CoachPoint(
                                  initial: '3',
                                  child: Material(
                                    color: transparent,
                                    child: Icon(FontAwesomeIcons.bookOpen),
                                  ),
                                ),
                                label: Text('Methodology', style: text),
                              ),
                              NavigationRailDestination(
                                icon: CoachPoint(
                                  initial: '4',
                                  child: Material(
                                    color: transparent,
                                    child: Icon(FontAwesomeIcons.quinscape),
                                  ),
                                ),
                                label: Text(S.current.questionsAndAnswers,
                                    style: text),
                              ),
                              NavigationRailDestination(
                                icon: CoachPoint(
                                  initial: '5',
                                  child: Material(
                                    color: transparent,
                                    child: Icon(FontAwesomeIcons.book),
                                  ),
                                ),
                                label: Text(S.current.generalKnowledge,
                                    style: text),
                              ),
                              NavigationRailDestination(
                                icon: CoachPoint(
                                  initial: '6',
                                  child: Material(
                                    color: transparent,
                                    child: Icon(FontAwesomeIcons.scroll),
                                  ),
                                ),
                                label: Text(S.current.references, style: text),
                              ),
                              NavigationRailDestination(
                                icon: CoachPoint(
                                  initial: '7',
                                  child: Material(
                                    color: transparent,
                                    child: Icon(FontAwesomeIcons.ussunnah),
                                  ),
                                ),
                                label:
                                    Text(S.current.shortPhrases, style: text),
                              ),
                            ],
                            extended: _isExtended.value!,
                            selectedIndex: _selectedIndex,
                            trailing: CoachPoint(
                              initial: '8',
                              child: CustomIconButton(
                                  icon: FontAwesomeIcons.mailBulk,
                                  onTap: () => Get.dialog(
                                        FeedDialog(ar: ar),
                                        transitionDuration: delay.duration,
                                        transitionCurve: Curves.easeIn,
                                        name: 'Feedback Dialog',
                                      ),
                                  data: 'Please provide your Feedback'),
                            ),
                            leading: CoachPoint(
                              initial: '9',
                              child:
                                  NavigationRailHeader(extended: _isExtended),
                            ),
                            onDestinationSelected: (index) {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                          );
                        }),
                  ),
                ),
              ),
            );
          }),
          VerticalDivider(
            thickness: 1,
            width: 1,
            endIndent: 44,
            indent: 45,
            color: theme.primaryColor.withOpacity(.1),
          ),
          Image.asset(
            'assets/images/divid.png',
            color: Theme.of(context).primaryColor.withOpacity(.05),
          ),
          Expanded(
            child: SharedAxisTransitionSwitcher(
              child: IMENav(
                child: Stack(
                  children: [
                    screens[_selectedIndex],
                    WindowTitleBarBox(
                      child: Row(
                        children: [
                          Expanded(child: MoveWindow()),
                          const WindowButtons()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  coachMaker() {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    final theme = Theme.of(context);
    final title = theme.textTheme.button!.copyWith(
        fontSize: kSpacingUnit * 1.5,
        fontFamily: ar ? 'Amiri' : 'Quicksand',
        fontWeight: FontWeight.w400,
        letterSpacing: 2);
    final sub = theme.textTheme.button!.copyWith(
        fontSize: kSpacingUnit * 1.3,
        fontFamily: ar ? 'Amiri' : 'Roboto',
        fontWeight: FontWeight.w100,
        letterSpacing: 2);
    CoachMaker(context, initialList: [
      CoachModel(
        initial: '1',
        maxWidth: 400,
        titleTextStyle: title,
        subtitleTextStyle: sub,
        title: S.current.quiz,
        alignment: ar ? Alignment.topLeft : Alignment.topRight,
        subtitle: [
          'Test your knowledge on different categories of quiz & fun puzzles',
        ],
      ),
      CoachModel(
        initial: '2',
        title: S.current.prerequisite,
        maxWidth: 400,
        titleTextStyle: title,
        subtitleTextStyle: sub,
        alignment: ar ? Alignment.centerLeft : Alignment.centerRight,
        subtitle: [
          '${S.current.tawheedIntroTitle}\n Learn the fundamentals upon which the religion of Islām is built.',
          'Base your religion in this life upon that which has been revealed by Allāh to His Messenger (ﷺ), and do not die except upon this.'
        ],
      ),
      CoachModel(
        initial: '3',
        title: 'Methodology',
        maxWidth: 400,
        titleTextStyle: title,
        subtitleTextStyle: sub,
        alignment: ar ? Alignment.centerLeft : Alignment.centerRight,
        subtitle: [
          'Learn on the best ways in seeking knowledge and expectations as a student of knowledge',
        ],
      ),
      CoachModel(
        initial: '4',
        title: S.current.questionsAndAnswers,
        maxWidth: 400,
        titleTextStyle: title,
        subtitleTextStyle: sub,
        alignment: ar ? Alignment.centerLeft : Alignment.centerRight,
        subtitle: [
          'Questions and answers from different scholars with rich definition from Al-Quran and Sunnah',
        ],
      ),
      CoachModel(
        initial: '5',
        title: S.current.generalKnowledge,
        maxWidth: 400,
        titleTextStyle: title,
        subtitleTextStyle: sub,
        alignment: ar ? Alignment.centerLeft : Alignment.bottomCenter,
        subtitle: [
          'Extracts and full documents & books to read and contemplate from',
        ],
      ),
      CoachModel(
        initial: '6',
        title: S.current.references,
        maxWidth: 400,
        titleTextStyle: title,
        subtitleTextStyle: sub,
        alignment: ar ? Alignment.centerLeft : Alignment.bottomRight,
        subtitle: [
          'References of each and every knowledge & Authors',
        ],
      ),
      CoachModel(
        initial: '7',
        title: S.current.shortPhrases,
        maxWidth: 400,
        titleTextStyle: title,
        subtitleTextStyle: sub,
        alignment: ar ? Alignment.bottomLeft : Alignment.bottomRight,
        subtitle: [
          'Get around the shortened contexts of the documents with Short Phrases predefined ',
        ],
      ),
      CoachModel(
        initial: '8',
        title: S.current.feedback,
        maxWidth: 400,
        titleTextStyle: title,
        subtitleTextStyle: sub,
        alignment: ar ? Alignment.bottomLeft : Alignment.bottomRight,
        subtitle: [
          'Tell us what you think about ${S.current.appTitle}, Try help or support, have a question. Provide feedback from here',
        ],
      ),
      CoachModel(
        initial: '9',
        title: S.current.settings,
        maxWidth: 400,
        titleTextStyle: title,
        subtitleTextStyle: sub,
        alignment: ar ? Alignment.center : Alignment.center,
        subtitle: [
          '${S.current.customizeExp}, ${S.current.chooseTheme}, &  ${MaterialLocalizations.of(context).aboutListTileTitle('IME')}',
        ],
      ),
    ]).show();
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).primaryColor;
    return Row(
      children: [
        MinimizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: theme.withOpacity(.5),
            mouseOver: theme.withOpacity(.5),
            mouseDown: theme.withOpacity(.5),
            iconMouseOver: Colors.white,
            iconMouseDown: Get.theme.backgroundColor,
          ),
        ),
        MaximizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: theme.withOpacity(.5),
            mouseOver: theme.withOpacity(.5),
            mouseDown: theme.withOpacity(.5),
            iconMouseOver: Colors.white,
            iconMouseDown: Get.theme.backgroundColor,
          ),
        ),
        CloseWindowButton(
          colors: WindowButtonColors(
            mouseOver: const Color(0xFFD32F2F).withOpacity(.5),
            mouseDown: const Color(0xFFB71C1C).withOpacity(.5),
            iconNormal: theme.withOpacity(.5),
            iconMouseOver: Colors.white,
          ),
        ),
      ],
    );
  }
}
