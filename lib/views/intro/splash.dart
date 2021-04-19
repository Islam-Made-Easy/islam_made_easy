import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/views/home.dart';
import 'package:islam_made_easy/widgets/anim/fade_slide.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashView extends StatefulWidget {
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
      animationDuration: const Duration(milliseconds: 1100),
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
      lottieAsset: 'assets/lottie/time.json',
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
      } else {
        glow = false;
      }
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = isDisplayDesktop(context);
    if (!isDesktop) {
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
                                // theme.primaryColorDark,
                                // theme.colorScheme.onBackground,
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
    } else {
      return Scaffold(
        backgroundColor: theme.primaryColorDark,
        floatingActionButton: Visibility(
          visible: onBoardPage,
          child: FadingSlidingWidget(
            animationController: _animationController,
            child: FloatingActionButton(
              onPressed: () => Get.to(() => Home()),
              backgroundColor: theme.primaryColorDark,
              child: glow
                  ? AvatarGlow(
                      endRadius: 30,
                      glowColor: theme.accentColor,
                      child: FaIcon(locale.languageCode == 'ar'
                          ? FontAwesomeIcons.angleLeft
                          : FontAwesomeIcons.angleRight),
                    )
                  : FaIcon(locale.languageCode == 'ar'
                      ? FontAwesomeIcons.angleLeft
                      : FontAwesomeIcons.angleRight),
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 100,
              left: locale.languageCode == 'ar' ? 760 : 200,
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: theme.splashColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: locale.languageCode == 'ar' ? 800 : 150,
              child: Container(
                height: 17,
                width: 300,
                decoration: BoxDecoration(
                  color: theme.splashColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: locale.languageCode == 'ar' ? 240 : 220,
              child: Material(
                color: theme.primaryColorDark,
                borderRadius: BorderRadius.circular(20),
                elevation: 50,
                child: Container(
                  height: 500,
                  width: size.width / 2 * 1.2,
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
                        bottom: height * 0.1,
                        left: locale.languageCode == 'ar'
                            ? width * 0.1
                            : width * 0.3,
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: onBoardItems.length,
                          effect: WormEffect(
                            dotWidth: 20,
                            dotHeight: 20,
                            dotColor: onBoardPage
                                ? const Color(0x11000000)
                                : const Color(0x566FFFFFF),
                            activeDotColor: const Color(0xFFFFFFFF),
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
        isDesktop
            ? Container()
            : Positioned.fill(
                child: Container(color: Theme.of(context).primaryColorDark),
              ),
        Positioned(
          top: isDesktop ? 0.0 : height * 0.2,
          child: Column(
            children: <Widget>[
              isDesktop
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
                              color: const Color(0xFFFFFFFF),
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
              SizedBox(height: isDesktop ? 0.0 : height * 0.01),
              FadingSlidingWidget(
                animationController: _animationController,
                interval: const Interval(0.5, 0.9),
                child: Text(
                  S.current.fridayRemind,
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: width * 0.08,
                  ),
                ),
              ),
              SizedBox(height: isDesktop ? 0 : height * 0.1),
              Container(
                width: isDesktop ? width * 0.4 : width * 0.9,
                child: FadingSlidingWidget(
                  animationController: _animationController,
                  interval: const Interval(0.7, 1.0),
                  child: Text(
                    S.current.fridayFirst,
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: isDesktop ? 30 : width * 0.056,
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
      padding: EdgeInsets.only(top: isDesktop ? 100 : height * 0.15),
      child: Column(
        children: <Widget>[
          Lottie.asset(
            widget.onBoardPageItem.lottieAsset,
            controller: _animationController,
            onLoaded: (composition) {
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
            },
            width: isDesktop ? 200 : width * 0.9,
          ),
          SizedBox(height: isDesktop ? 20 : height * 0.1),
          Flexible(
            child: FadingSlidingWidget(
              animationController: _animationController,
              interval: const Interval(0.2, 0.5),
              child: Text(
                widget.onBoardPageItem.text,
                style: TextStyle(fontSize: isDesktop ? 40 : width * 0.05),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
