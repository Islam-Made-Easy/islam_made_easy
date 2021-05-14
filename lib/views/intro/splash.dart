import 'package:islam_made_easy/views/QnA/qna.dart';

class SplashView extends StatefulWidget {
  static const ROUTE_NAME = "/fridayReminder";

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  List<OnBoardPageItem> onboardPageItems = [
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/bookI.json',
      text: 'Read Sūrat Al-Kahf',
    ),
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/bath.json',
      text: 'Ghusl Before Jum\'ah Prayer',
    ),
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/hand.json',
      text: '‎Trim Nails',
    ),
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/brush.json',
      text: 'Miswāk Before  Ablution',
    ),
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/book.json',
      text: 'Musk for men only',
    ),
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/cloth.json',
      text: 'Clean New Clothes',
    ),
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/audio.json',
      text: 'Convey peace & blessings to Prophet ﷺ ',
    ),
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/timeAnim.json',
      text: 'Go Early To The Mosque',
    ),
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/converse.json',
      text: 'Listen To The Khutbah',
    ),
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/clock.json',
      text: 'Catch The Best Hour for dua',
    ),
  ];

  PageController _pageController;

  List<Widget> onBoardItems = [];
  double _activeIndex;
  bool onBoardPage = false;
  bool glow = false;
  AnimationController _animationController;

  @override
  void initState() {
    initializePages(); //initialize pages to be shown
    _pageController = PageController();
    _pageController.addListener(() {
      _activeIndex = _pageController.page;
      // print("Active Index: $_activeIndex");
      if (_activeIndex >= 0.5 && onBoardPage == false) {
        setState(() {
          onBoardPage = true;
        });
      } else if (_activeIndex < 0.5) {
        setState(() {
          onBoardPage = false;
        });
      } else if (_activeIndex == 10.0) {
        setState(() {
          glow = true;
        });
      }
      glow = false;
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..forward();
    super.initState();
  }

  initializePages() {
    onBoardItems.add(WelcomePage()); // welcome page
    onboardPageItems.forEach((onboardPageItem) {
      onBoardItems.add(OnBoardPage(onBoardPageItem: onboardPageItem));
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    // final isDesktop = isDisplayDesktop(context);
    if (DeviceOS.isDesktopOrWeb && context.isTablet) {
      return Scaffold(
        backgroundColor: theme.primaryColorDark,
        floatingActionButton: Visibility(
          visible: onBoardPage,
          child: FadingSlidingWidget(
            animationController: _animationController,
            child: FloatingActionButton(
              onPressed: () => Get.off(() => Home()),
              backgroundColor: theme.primaryColorDark,
              child: glow
                  ? AvatarGlow(
                      endRadius: 30,
                      glowColor: theme.accentColor,
                      child: FaIcon(ar
                          ? FontAwesomeIcons.angleLeft
                          : FontAwesomeIcons.angleRight),
                    )
                  : FaIcon(ar
                      ? FontAwesomeIcons.angleLeft
                      : FontAwesomeIcons.angleRight),
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: height * 0.11,
              left: ar ? width * 0.6 : width * 0.165,
              right: ar ? width * 0.16 : width * 0.6,
              child: FadingSlidingWidget(
                animationController: _animationController,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: height * 0.45,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                    color: theme.splashColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: ar ? width * 0.6 : width * 0.15,
              left: ar ? width * 0.15 : width * 0.6,
              child: FadingSlidingWidget(
                animationController: _animationController,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: height * 0.03,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                    color: theme.splashColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.15,
              left: ar ? width * 0.18 : width * 0.185,
              right: ar ? width * 0.186 : width * 0.18,
              child: Material(
                color: theme.primaryColorDark,
                borderRadius: BorderRadius.circular(20),
                elevation: 50,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: height * 0.75,
                  width: width * 0.65,
                  decoration: BoxDecoration(
                    color: theme.primaryColorDark,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Theme.of(context).backgroundColor,
                        style: BorderStyle.none),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: PageView(
                            controller: _pageController,
                            children: onBoardItems),
                      ),
                      Positioned(
                        bottom: height * 0.03,
                        left: ar ? width * 0.1 : width * 0.3,
                        right: ar ? width * 0.3 : width * 0.1,
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: onBoardItems.length,
                          effect: WormEffect(
                            dotWidth: width * 0.015,
                            dotHeight: width * 0.015,
                            dotColor: onBoardPage
                                ? const Color(0x11000000)
                                : const Color(0x566FFFFFF),
                            activeDotColor: const Color(0xffeef2f5),
                          ),
                        ),
                      ),
                      Positioned(
                        right: ar ? null : 1,
                        left: ar ? 1 : null,
                        top: height * 0.35,
                        child: _activeIndex == 10
                            ? Container()
                            : Visibility(
                                visible: DeviceOS.isDesktopOrWeb,
                                child: AnimContainer(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: theme.primaryColorDark,
                                          offset: Offset(8.0, 8.0),
                                          blurRadius: 20,
                                          spreadRadius: 1.0),
                                      BoxShadow(
                                          color: theme.primaryColorDark,
                                          offset: Offset(-8.0, -8.0),
                                          blurRadius: 20,
                                          spreadRadius: 1.0),
                                    ],
                                    gradient: gradient,
                                    color: theme.primaryColorDark,
                                    border: Border.all(
                                        color:
                                            Color(0xffeef2f5).withOpacity(0.5)),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _pageController.nextPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                      });
                                    },
                                    icon: FaIcon(ar
                                        ? FontAwesomeIcons.angleLeft
                                        : FontAwesomeIcons.angleRight),
                                  ),
                                ),
                              ),
                      ),
                      Visibility(
                        visible: onBoardPage,
                        child: Positioned(
                          right: ar ? 1 : null,
                          left: ar ? null : 1,
                          top: height * 0.35,
                          child: AnimContainer(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: theme.primaryColorDark,
                                    offset: Offset(8.0, 8.0),
                                    blurRadius: 20,
                                    spreadRadius: 1.0),
                                BoxShadow(
                                    color: theme.primaryColorDark,
                                    offset: Offset(-8.0, -8.0),
                                    blurRadius: 20,
                                    spreadRadius: 1.0),
                              ],
                              gradient: gradient,
                              color: theme.primaryColorDark,
                              border: Border.all(
                                  color: Color(0xffeef2f5).withOpacity(0.5)),
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _pageController.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeOut);
                                });
                              },
                              icon: FaIcon(ar
                                  ? FontAwesomeIcons.angleRight
                                  : FontAwesomeIcons.angleLeft),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
              child:
                  PageView(controller: _pageController, children: onBoardItems),
            ),
            Positioned(
              bottom: height * 0.15,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: onBoardItems.length,
                effect: WormEffect(
                  dotWidth: width * 0.03,
                  dotHeight: width * 0.03,
                  dotColor: onBoardPage
                      ? const Color(0x11000000)
                      : const Color(0x566FFFFFF),
                  activeDotColor: onBoardPage
                      ? Theme.of(context).primaryColorDark
                      : const Color(0xFFFFFFFF),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  if (onBoardPage) Get.off(() => Home());
                },
                child: FadingSlidingWidget(
                  animationController: _animationController,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.center,
                    width: width * 0.8,
                    height: height * 0.075,
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: onBoardPage
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF220555),
                        fontSize: width * 0.05,
                      ),
                    ),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.1),
                      ),
                      gradient: LinearGradient(
                        colors: onBoardPage
                            ? [
                                const Color(0xFF8200FF),
                                const Color(0xFFFF3264),
                              ]
                            : [
                                const Color(0xFFFFFFFF),
                                const Color(0xFFFFFFFF),
                              ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class OnBoardPageItem {
  String lottieAsset;
  Duration animationDuration;
  String text;

  OnBoardPageItem(
      {@required this.lottieAsset,
      @required this.text,
      this.animationDuration});
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final isDesktop = isDisplayDesktop(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        DeviceOS.isDesktopOrWeb && context.isTablet
            ? Container()
            : Positioned.fill(
                child: Container(color: Theme.of(context).primaryColorDark),
              ),
        Positioned(
          top: isDesktop ? 0.0 : height * 0.14,
          child: Column(
            children: <Widget>[
                DeviceOS.isDesktopOrWeb && !context.isPhone
                  ? Container()
                  : ScaleTransition(
                      scale: _animationController.drive(
                        Tween<double>(begin: 0.3, end: 1.0).chain(
                          CurveTween(
                            curve:
                                Interval(0.0, 0.2, curve: Curves.elasticInOut),
                          ),
                        ),
                      ),
                      child: FadeTransition(
                        opacity: _animationController.drive(
                          Tween<double>(begin: 0.0, end: 1.0).chain(
                            CurveTween(
                              curve:
                                  Interval(0.2, 0.4, curve: Curves.decelerate),
                            ),
                          ),
                        ),
                        child: ScaleTransition(
                          scale: _animationController.drive(
                            Tween<double>(begin: 1.3, end: 1.0).chain(
                              CurveTween(
                                curve: Interval(0.2, 0.4,
                                    curve: Curves.elasticInOut),
                              ),
                            ),
                          ),
                          child: Container(
                            width: width * 0.3,
                            height: width * 0.3,
                            decoration: ShapeDecoration(
                              color: Theme.of(context).hoverColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.08),
                              ),
                            ),
                            child: Image.asset('assets/images/logo.png',
                                scale: 0.9),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: isDesktop ? 0.0 : height * 0.015),
              FadingSlidingWidget(
                animationController: _animationController,
                interval: const Interval(0.5, 0.9),
                child: Text(
                  S.current.fridayRemind,
                  style: TextStyle(fontFamily: 'Amiri',
                    color: const Color(0xFFFFFFFF),
                    fontSize: width * 0.08,
                  ),
                ),
              ),
              SizedBox(height: isDesktop ? 0.0 : height * 0.015),
              FadingSlidingWidget(
                animationController: _animationController,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  width: DeviceOS.isDesktopOrWeb && !context.isPhone
                      ? width * 0.4
                      : width * 0.9,
                  child: FadingSlidingWidget(
                    animationController: _animationController,
                    interval: const Interval(0.7, 1.0),
                    child: Text(
                      S.current.fridayFirst,
                      style: TextStyle(
                        color: const Color(0xFFFFFFFF),fontFamily: 'Amiri',
                        fontSize: DeviceOS.isDesktopOrWeb && context.isTablet
                            ? width * 0.02
                            : width * 0.056,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OnBoardPage extends StatefulWidget {
  final OnBoardPageItem onBoardPageItem;

  OnBoardPage({this.onBoardPageItem});

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<OnBoardPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final isDesktop = isDisplayDesktop(context);
    return Container(
      padding: EdgeInsets.only(top: height * 0.1),
      child: Column(
        children: <Widget>[
          Lottie.asset(widget.onBoardPageItem.lottieAsset,
              controller: _animationController, onLoaded: (composition) {
            _animationController
              ..duration = composition.duration
              ..forward()
              ..addListener(() {
                if (widget.onBoardPageItem.animationDuration != null) {
                  if (_animationController.lastElapsedDuration >
                      widget.onBoardPageItem.animationDuration) {
                    _animationController.stop();
                  }
                }
              });
          }, width: isDesktop?width * 0.15:width * 0.9),
          SizedBox(height: context.isTablet ? height * 0.01 : height * 0.1),
          Flexible(
            child: FadingSlidingWidget(
              animationController: _animationController,
              interval: const Interval(0.2, 0.5),
              child: Text(
                widget.onBoardPageItem.text,
                style: TextStyle(
                    fontSize: isDesktop ? width * 0.04 : width * 0.05),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
