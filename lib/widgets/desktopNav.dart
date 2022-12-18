import 'package:bitsdojo_window/bitsdojo_window.dart';
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
    return Row(
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
                        return Stack(
                          children: [
                            FocusTraversalGroup(
                              child: NavigationRail(
                                destinations: [
                                  NavigationRailDestination(
                                    icon: Material(
                                      color: transparent,
                                      borderRadius: BorderRadius.zero,
                                      child: Icon(FontAwesomeIcons.quora),
                                    ),
                                    label: Text(S.current.quiz, style: text),
                                  ),
                                  NavigationRailDestination(
                                    icon: Material(
                                      color: transparent,
                                      child: Icon(FontAwesomeIcons.fileAlt),
                                    ),
                                    label: Text(S.current.prerequisite,
                                        style: text),
                                  ),
                                  NavigationRailDestination(
                                    icon: Material(
                                      color: transparent,
                                      child: Icon(FontAwesomeIcons.bookOpen),
                                    ),
                                    label: Text('Methodology', style: text),
                                  ),
                                  NavigationRailDestination(
                                    icon: Material(
                                      color: transparent,
                                      child: Icon(FontAwesomeIcons.quinscape),
                                    ),
                                    label: Text(S.current.questionsAndAnswers,
                                        style: text),
                                  ),
                                  NavigationRailDestination(
                                    icon: Material(
                                      color: transparent,
                                      child: Icon(FontAwesomeIcons.book),
                                    ),
                                    label: Text(S.current.generalKnowledge,
                                        style: text),
                                  ),
                                  NavigationRailDestination(
                                    icon: Material(
                                      color: transparent,
                                      child: Icon(FontAwesomeIcons.scroll),
                                    ),
                                    label:
                                        Text(S.current.references, style: text),
                                  ),
                                  NavigationRailDestination(
                                    icon: Material(
                                      color: transparent,
                                      child: Icon(FontAwesomeIcons.ussunnah),
                                    ),
                                    label: Text(S.current.shortPhrases,
                                        style: text),
                                  ),
                                ],
                                extended: _isExtended.value!,
                                selectedIndex: _selectedIndex,
                                trailing: CustomIconButton(
                                    icon: FontAwesomeIcons.mailBulk,
                                    onTap: () {
                                      Get.dialog(FeedDialog(ar: ar),
                                          transitionDuration: delay.duration,
                                          transitionCurve: Curves.easeIn,
                                          name: 'Feedback Dialog');
                                    },
                                    data: 'Please provide your Feedback'),
                                leading:
                                    NavigationRailHeader(extended: _isExtended),
                                onDestinationSelected: (index) {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                              ),
                            ),
                          ],
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
          color: theme.primaryColor.withOpacity(.3),
        ),
        Image.asset(
          'assets/images/divid.png',
          color: Theme.of(context).primaryColor.withOpacity(.5),
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
    );
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
