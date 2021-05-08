import 'package:islam_made_easy/views/QnA/qna.dart';

import 'anim/ime_nav.dart';
import 'anim/shared_switcher.dart';
import 'feedback.dart';
import 'navHeader.dart';

class DesktopNav extends StatefulWidget {
  const DesktopNav({this.extended});

  final bool extended;

  @override
  _DesktopNavState createState() => _DesktopNavState();
}

class _DesktopNavState extends State<DesktopNav>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> _isExtended;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
    _isExtended = ValueNotifier<bool>(widget.extended);
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
    return Row(
      children: [
        LayoutBuilder(builder: (context, constraints) {
          return Container(
            color: Theme.of(context).navigationRailTheme.backgroundColor,
            child: SingleChildScrollView(
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: ValueListenableBuilder<bool>(
                      valueListenable: _isExtended,
                      builder: (context, value, child) {
                        return Stack(
                          children: [
                            NavigationRail(
                              destinations: [
                                NavigationRailDestination(
                                  icon: Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.zero,
                                      child: FaIcon(PixIcon.fab_quora)),
                                  label: Text(S.current.quiz),
                                ),
                                NavigationRailDestination(
                                  icon: Material(
                                      color: Colors.transparent,
                                      child:
                                          FaIcon(PixIcon.typcn_document_text)),
                                  label: Text(S.current.prerequisite),
                                ),
                                NavigationRailDestination(
                                  icon: Material(
                                      color: Colors.transparent,
                                      child: FaIcon(PixIcon.fa_book_open)),
                                  label: Text('Methodology'),
                                ),
                                NavigationRailDestination(
                                  icon: Material(
                                      color: Colors.transparent,
                                      child: FaIcon(PixIcon.fab_quinscape)),
                                  label: Text(S.current.questionsAndAnswers),
                                ),
                                NavigationRailDestination(
                                  icon: Material(
                                      color: Colors.transparent,
                                      child: FaIcon(PixIcon.pix_book)),
                                  label: Text(S.current.generalKnowledge),
                                ),
                                NavigationRailDestination(
                                  icon: Material(
                                      color: Colors.transparent,
                                      child: FaIcon(PixIcon.fa_scroll)),
                                  label: Text(S.current.references),
                                ),
                                NavigationRailDestination(
                                  icon: Material(
                                      color: Colors.transparent,
                                      child: FaIcon(PixIcon.fab_ussunnah)),
                                  label: Text(S.current.shortPhrases),
                                ),
                              ],
                              extended: _isExtended.value,
                              selectedIndex: _selectedIndex,
                              labelType: NavigationRailLabelType.none,
                              backgroundColor: Color(0xFFF2F2F2),
                              leading:
                                  NavigationRailHeader(extended: _isExtended),
                              onDestinationSelected: (index) {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              // groupAlignment: 1.0,
                            ),
                            Positioned(
                              bottom: -size.height * 0.1,
                              left: ar
                                  ? isDesktop
                                      ? size.width * 0.05
                                      : size.width * 0.43
                                  : 0,
                              right: ar
                                  ? 0
                                  : isDesktop
                                      ? size.width * 0.05
                                      : size.width * 0.43,
                              child: Container(
                                height: size.height * 0.165,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomLeft: ar
                                          ? Radius.elliptical(50, 120)
                                          : Radius.zero,
                                      bottomRight: ar
                                          ? Radius.zero
                                          : Radius.elliptical(50, 120)),
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).accentColor,
                                      Theme.of(context).backgroundColor
                                    ],
                                    tileMode: TileMode.mirror,
                                    begin: ar
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    end: !ar
                                        ? Alignment.bottomLeft
                                        : Alignment.bottomRight,
                                    stops: [0.0, 1.0],
                                  ),
                                ),
                                child: GestureDetector(
                                  onTapDown: _tapDown,
                                  onTap: () {
                                    Get.dialog(
                                      Align(
                                        alignment: ar
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                        child: Container(
                                          height: double.infinity,
                                          width: MediaQuery.of(context)
                                                  .size.width / 2,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFAFAFC),
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(ar ? 0 : 20),
                                              bottomRight:
                                                  Radius.circular(ar ? 20 : 0),
                                              bottomLeft:
                                                  Radius.circular(ar ? 0 : 20),
                                              topRight:
                                                  Radius.circular(ar ? 20 : 0),
                                            ),
                                          ),
                                          child: AppFeedback(),
                                        ),
                                      ),
                                      transitionDuration: delay.duration,
                                      transitionCurve: Curves.easeIn,
                                    );
                                  },
                                  onTapUp: _tapUp,
                                  child: Transform.scale(
                                    scale: _scale,
                                    child: _animatedButton(),
                                  ),
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
        const VerticalDivider(
          thickness: 1,
          width: 1,
          color: Color(0xFFF2F2F2),
        ),
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
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.only(
          topRight:
              ar ? Radius.elliptical(90, 10) : Radius.elliptical(162, 200),
          topLeft: ar ? Radius.elliptical(12, 200) : Radius.elliptical(10, 10),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF383838),
            blurRadius: 12.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'Feedback',
          style: TextStyle(
              fontSize: 50.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
