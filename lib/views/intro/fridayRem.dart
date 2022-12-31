import 'package:islam_made_easy/views/QnA/qna.dart';

class FridayRem extends StatefulWidget {
  static const ROUTE_NAME = "/fridayReminder";

  @override
  _FridayRemState createState() => _FridayRemState();
}

class _FridayRemState extends State<FridayRem> with TickerProviderStateMixin {
  List<OnBoardPageItem> onboardPageItems = [
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/bookI.json',
      text: 'Read Sūrat Al-Kahf',
    ),
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/bath.json',
      text: 'Ghusl Before Jum\'ah Prayer',
    ),
    OnBoardPageItem(lottieAsset: 'assets/lottie/hand.json', text: 'Trim Nails'),
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

  PageController? _pageController;

  List<Widget> onBoardItems = [];
  double? _activeIndex;
  bool onBoardPage = false, glow = false;
  AnimationController? _anim;

  @override
  void initState() {
    initializePages();
    _pageController = PageController();
    _pageController!.addListener(() {
      _activeIndex = _pageController!.page;
      if (_activeIndex! >= .5 && onBoardPage == false) {
        setState(() {
          onBoardPage = true;
        });
      } else if (_activeIndex! < .5) {
        setState(() {
          onBoardPage = false;
        });
      } else if (_activeIndex == 10.0) {
        setState(() {
          glow = true;
        });
      }
    });
    _anim = AnimationController(
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
    final isDesktop = isDisplayDesktop(context);
    if (DeviceOS.isDesktopOrWeb && isDesktop) {
      return CallbackShortcuts(
        bindings: {
          SingleActivator(
            ar ? LogicalKeyboardKey.arrowLeft : LogicalKeyboardKey.arrowRight,
          ): () {
            setState(() {
              _pageController!.nextPage(
                  duration: Duration(milliseconds: 300), curve: Curves.easeOut);
            });
          },
          SingleActivator(
            ar ? LogicalKeyboardKey.arrowRight : LogicalKeyboardKey.arrowLeft,
          ): () {
            setState(() {
              _pageController!.previousPage(
                  duration: Duration(milliseconds: 300), curve: Curves.easeOut);
            });
          }
        },
        child: Scaffold(
          backgroundColor: theme.colorScheme.primary,
          floatingActionButton: Visibility(
            visible: onBoardPage,
            child: FadingSlidingWidget(
              anim: _anim,
              child: FloatingActionButton(
                onPressed: () => Get.off(() => Home()),
                backgroundColor: theme.colorScheme.primary,
                child: AvatarGlow(
                  endRadius: 50,
                  glowColor:
                      glow ? Colors.white : theme.primaryColor.withOpacity(.05),
                  child: FaIcon(Icons.chevron_right, color: Colors.white),
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              Positioned(
                top: height * .11,
                left: ar ? width * .6 : width * .165,
                right: ar ? width * .16 : width * .6,
                child: FadingSlidingWidget(
                  anim: _anim,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: height * .45,
                    width: width * .25,
                    decoration: BoxDecoration(
                      color: theme.splashColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: ar ? width * .6 : width * .15,
                left: ar ? width * .15 : width * .6,
                child: FadingSlidingWidget(
                  anim: _anim,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: height * .03,
                    width: width * .25,
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
                top: height * .15,
                left: ar ? width * .18 : width * .185,
                right: ar ? width * .186 : width * .18,
                child: Material(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                  elevation: 50,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: height * .75,
                    width: width * .65,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Theme.of(context).backgroundColor,
                          style: BorderStyle.none),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: ar ? 200 : -200,
                          right: ar ? -150 : 150,
                          child: Transform.rotate(
                            angle: onBoardPage
                                ? 0
                                : _pageController!.viewportFraction + 120,
                            child: Opacity(
                              opacity: .1,
                              child: Image.asset(
                                'assets/images/cir.png',
                                matchTextDirection: true,
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: PageView(
                              controller: _pageController,
                              children: onBoardItems),
                        ),
                        Positioned(
                          bottom: height * .03,
                          left: ar ? width * .1 : width * .3,
                          right: ar ? width * .3 : width * .1,
                          child: SmoothPageIndicator(
                            controller: _pageController!,
                            count: onBoardItems.length,
                            effect: WormEffect(
                              dotWidth: width * .015,
                              dotHeight: width * .015,
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
                          top: height * .35,
                          child: _activeIndex == 10
                              ? Container()
                              : Visibility(
                                  visible: DeviceOS.isDesktopOrWeb,
                                  child: AnimContainer(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: theme.colorScheme.primary,
                                            offset: Offset(8.0, 8.0),
                                            blurRadius: 20,
                                            spreadRadius: 1.0),
                                        BoxShadow(
                                            color: theme.colorScheme.primary,
                                            offset: Offset(-8.0, -8.0),
                                            blurRadius: 20,
                                            spreadRadius: 1.0),
                                      ],
                                      gradient: gradient,
                                      color: theme.colorScheme.primary,
                                      border: Border.all(
                                          color: Color(0xffeef2f5)
                                              .withOpacity(.5)),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _pageController!.nextPage(
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeOut);
                                        });
                                      },
                                      icon: FaIcon(Icons.chevron_right),
                                    ),
                                  ),
                                ),
                        ),
                        Visibility(
                          visible: onBoardPage,
                          child: Positioned(
                            right: ar ? 1 : null,
                            left: ar ? null : 1,
                            top: height * .35,
                            child: AnimContainer(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: theme.colorScheme.primary,
                                      offset: Offset(8.0, 8.0),
                                      blurRadius: 20,
                                      spreadRadius: 1.0),
                                  BoxShadow(
                                      color: theme.colorScheme.primary,
                                      offset: Offset(-8.0, -8.0),
                                      blurRadius: 20,
                                      spreadRadius: 1.0),
                                ],
                                gradient: gradient,
                                color: theme.colorScheme.primary,
                                border: Border.all(
                                    color: Color(0xffeef2f5).withOpacity(.5)),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _pageController!.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                  });
                                },
                                icon: FaIcon(Icons.chevron_left),
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
              bottom: height * .15,
              child: SmoothPageIndicator(
                controller: _pageController!,
                count: onBoardItems.length,
                effect: WormEffect(
                  dotWidth: width * .03,
                  dotHeight: width * .03,
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
                  anim: _anim,
                  child: AnimatedContainer(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * .1),
                      ),
                      gradient: LinearGradient(
                        colors: onBoardPage
                            ? [
                                const Color(0xFF8200FF),
                                const Color(0xFFFF3264),
                              ]
                            : [
                                const Color(0xFF8200FF),
                                const Color(0xFFFF3264),
                              ],
                      ),
                    ),
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.center,
                    width: width * .8,
                    height: height * .075,
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          color: onBoardPage
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFF220555),
                          fontSize: width * .05,
                          fontFamily: 'Quicksand'),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}

class OnBoardPageItem {
  String? lottieAsset, text;
  Duration? animationDuration;

  OnBoardPageItem({this.lottieAsset, this.text, this.animationDuration});
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _anim;

  @override
  void initState() {
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _anim!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        DeviceOS.isDesktopOrWeb && context.isTablet
            ? Container()
            : Positioned.fill(
                child: Container(color: Theme.of(context).primaryColor),
              ),
        Positioned(
          top: isDesktop || context.isTablet ? .0 : height * .1,
          child: Column(
            children: <Widget>[
              DeviceOS.isDesktopOrWeb && !context.isPhone
                  ? Container()
                  : ScaleTransition(
                      scale: _anim!.drive(
                        Tween<double>(begin: .3, end: 1.0).chain(
                          CurveTween(
                            curve: Interval(.0, .2, curve: Curves.elasticInOut),
                          ),
                        ),
                      ),
                      child: FadeTransition(
                        opacity: _anim!.drive(
                          Tween<double>(begin: .0, end: 1.0).chain(
                            CurveTween(
                              curve: Interval(.2, .4, curve: Curves.decelerate),
                            ),
                          ),
                        ),
                        child: ScaleTransition(
                          scale: _anim!.drive(
                            Tween<double>(begin: 1.3, end: 1.0).chain(
                              CurveTween(
                                curve: Interval(.2, .4,
                                    curve: Curves.elasticInOut),
                              ),
                            ),
                          ),
                          child: Container(
                            width: width * .3,
                            height: width * .3,
                            decoration: ShapeDecoration(
                              color: Theme.of(context).hoverColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(width * .08),
                              ),
                            ),
                            child: Image.asset('assets/images/ctr.png'),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: isDesktop ? .0 : height * .02),
              FadingSlidingWidget(
                anim: _anim,
                interval: const Interval(.5, .9),
                child: Text(
                  S.current.fridayRemind,
                  style: TextStyle(
                    fontSize: width * .07,
                    fontFamily: ar ? 'Amiri' : 'Quicksand',
                  ),
                ),
              ),
              SizedBox(height: isDesktop ? .0 : height * .015),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: DeviceOS.isDesktopOrWeb && !context.isPhone
                    ? width * .4
                    : width * .9,
                child: FadingSlidingWidget(
                  anim: _anim,
                  interval: const Interval(.7, 1.0),
                  child: Text(
                    S.current.fridayFirst,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontFamily: ar ? 'Amiri' : 'Quicksand',
                      fontSize: DeviceOS.isDesktopOrWeb && context.isTablet
                          ? width * .02
                          : width * .056,
                    ),
                    textAlign: TextAlign.center,
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
  final OnBoardPageItem? onBoardPageItem;

  OnBoardPage({this.onBoardPageItem});

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<OnBoardPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _anim;

  @override
  void initState() {
    _anim = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _anim!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final isDesktop = isDisplayDesktop(context);
    return Container(
      padding: EdgeInsets.only(top: height * .1),
      child: Column(
        children: <Widget>[
          Lottie.asset(widget.onBoardPageItem!.lottieAsset!, controller: _anim,
              onLoaded: (composition) {
            _anim!
              ..duration = composition.duration
              ..forward()
              ..addListener(() {
                if (widget.onBoardPageItem!.animationDuration != null) {
                  if (_anim!.lastElapsedDuration! >
                      widget.onBoardPageItem!.animationDuration!) {
                    _anim!.stop();
                  }
                }
              });
          }, width: isDesktop ? width * .15 : width * .9),
          SizedBox(height: context.isTablet ? height * .01 : height * .1),
          Flexible(
            child: FadingSlidingWidget(
              anim: _anim,
              interval: const Interval(.2, .5),
              child: Text(
                widget.onBoardPageItem!.text!,
                style: TextStyle(
                    fontFamily: 'QuickSand',
                    fontSize: isDesktop ? width * .04 : width * .05),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
