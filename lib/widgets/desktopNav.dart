import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/anim/ime_nav.dart';
import 'package:islam_made_easy/widgets/anim/shared_switcher.dart';
import 'package:islam_made_easy/widgets/navHeader.dart';
import 'package:islam_made_easy/widgets/popup_menu.dart';

class DesktopNav extends StatefulWidget {
  const DesktopNav({this.extended});

  final bool? extended;

  @override
  _DesktopNavState createState() => _DesktopNavState();
}

class _DesktopNavState extends State<DesktopNav> with SingleTickerProviderStateMixin {
  late ValueNotifier<bool?> _isExtended;
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: .0,
      upperBound: .1,
    )..addListener(() => setState(() {}));
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
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final transparent =Colors.transparent;
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
                            NavigationRail(
                              destinations: [
                                NavigationRailDestination(
                                  icon: Material(
                                      color: transparent,
                                      borderRadius: BorderRadius.zero,
                                      child: FaIcon(FontAwesomeIcons.quora)),
                                  label: Text(S.current.quiz),
                                ),
                                NavigationRailDestination(
                                  icon: Material(
                                      color: transparent,
                                      child: FaIcon(Icons.assignment)),
                                  label: Text(S.current.prerequisite),
                                ),
                                NavigationRailDestination(
                                  icon: Material(
                                      color: transparent,
                                      child: FaIcon(FontAwesomeIcons.bookOpen)),
                                  label: Text('Methodology'),
                                ),
                                NavigationRailDestination(
                                  icon: Material(
                                      color: transparent,
                                      child: FaIcon(FontAwesomeIcons.quinscape)),
                                  label: Text(S.current.questionsAndAnswers),
                                ),
                                NavigationRailDestination(
                                  icon: Material(
                                      color: transparent,
                                      child: FaIcon(FontAwesomeIcons.book)),
                                  label: Text(S.current.generalKnowledge),
                                ),
                                NavigationRailDestination(
                                  icon: Material(
                                      color: transparent,
                                      child: FaIcon(FontAwesomeIcons.scroll)),
                                  label: Text(S.current.references),
                                ),
                                NavigationRailDestination(
                                  icon: Material(
                                      color: transparent,
                                      child: FaIcon(FontAwesomeIcons.ussunnah)),
                                  label: Text(S.current.shortPhrases),
                                ),
                              ],
                              extended: _isExtended.value!,
                              selectedIndex: _selectedIndex,
                              leading:
                                  NavigationRailHeader(extended: _isExtended),
                              onDestinationSelected: (index) {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                            ),
                            Positioned(
                              bottom: -size.height * .1,
                              left: ar ? isDesktop ? size.width * .05 : size.width * .43 : 0,
                              right: ar ? 0 : isDesktop ? size.width * .05 : size.width * .43,
                              child: Container(
                                height: size.height * .165,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomLeft: ar ? Radius.elliptical(50, 120) : Radius.zero,
                                      bottomRight: ar ? Radius.zero : Radius.elliptical(50, 120)),
                                  gradient: LinearGradient(
                                    colors: [
                                      theme.colorScheme.secondary,
                                      theme.backgroundColor
                                    ],
                                    tileMode: TileMode.mirror,
                                    begin: ar ? Alignment.topRight : Alignment.topLeft,
                                    end: !ar ? Alignment.bottomLeft : Alignment.bottomRight,
                                    stops: [.0, 1.0],
                                  ),
                                ),
                                child: GestureDetector(
                                  onTapDown: _tapDown,
                                  onTap: () {
                                    Get.dialog(FeedDialog(ar: ar),
                                        transitionDuration: delay.duration,
                                        transitionCurve: Curves.easeIn,
                                        name: 'Feedback Dialog');
                                  },
                                  onTapUp: _tapUp,
                                  child: Transform.scale(
                                      scale: _scale, child: _animatedButton()),
                                ),
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
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: SharedAxisTransitionSwitcher(
            child: IMENav(child: screens[_selectedIndex]),
          ),
        )
      ],
    );
  }

  void _tapDown(TapDownDetails details) => _controller.forward();

  void _tapUp(TapUpDetails details) => _controller.reverse();

  Widget _animatedButton() {
    return Container(
      child: Center(
        child: Text(
          'Feedback',
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 50.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
