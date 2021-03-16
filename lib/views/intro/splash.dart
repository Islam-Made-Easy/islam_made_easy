import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/views/home.dart';
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
      lottieAsset: 'assets/lottie/check.json',
      text: 'Read Sūrat Al-Kahf',
    ),
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/404.json',
      text: 'Ghusl Before Jum\'ah Prayer',
      animationDuration: const Duration(milliseconds: 1100),
    ),
    OnBoardPageItem(
      lottieAsset: 'assets/lottie/404.json',
      text: 'Convey peace & blessings to Prophet ﷺ ',
    ),
  ];

  PageController _pageController;

  List<Widget> onBoardItems = [];
  double _activeIndex;
  bool onboardPage = false;
  AnimationController _animationController;

  @override
  void initState() {
    initializePages(); //initialize pages to be shown
    _pageController = PageController();
    _pageController.addListener(() {
      _activeIndex = _pageController.page;
      print("Active Index: $_activeIndex");
      if (_activeIndex >= 0.5 && onboardPage == false) {
        setState(() {
          onboardPage = true;
        });
      } else if (_activeIndex < 0.5) {
        setState(() {
          onboardPage = false;
        });
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                dotColor: onboardPage
                    ? const Color(0x11000000)
                    : const Color(0x566FFFFFF),
                activeDotColor: onboardPage
                    ? Theme.of(context).primaryColorDark
                    : const Color(0xFFFFFFFF),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: GestureDetector(
              onTap: () => Get.to(() => Home()),
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
                      color: onboardPage
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
                      colors: onboardPage
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
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Positioned.fill(
          child: Image.asset('assets/images/viewT.png', fit: BoxFit.fill),
        ),
        Positioned(
          top: height * 0.2,
          child: Column(
            children: <Widget>[
              ScaleTransition(
                scale: _animationController.drive(
                  Tween<double>(begin: 0.3, end: 1.0).chain(
                    CurveTween(
                      curve: Interval(0.0, 0.2, curve: Curves.elasticInOut),
                    ),
                  ),
                ),
                child: FadeTransition(
                  opacity: _animationController.drive(
                    Tween<double>(begin: 0.0, end: 1.0).chain(
                      CurveTween(
                        curve: Interval(0.2, 0.4, curve: Curves.decelerate),
                      ),
                    ),
                  ),
                  child: ScaleTransition(
                    scale: _animationController.drive(
                      Tween<double>(begin: 1.3, end: 1.0).chain(
                        CurveTween(
                          curve: Interval(0.2, 0.4, curve: Curves.elasticInOut),
                        ),
                      ),
                    ),
                    child: Container(
                      width: width * 0.3,
                      height: width * 0.3,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.08),
                        ),
                      ),
                      child: Image.asset('assets/images/logo.png', scale: 0.9),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              FadingSlidingWidget(
                animationController: _animationController,
                interval: const Interval(0.5, 0.9),
                child: Text(
                  'Friday Reminders',
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: width * 0.08,
                  ),
                ),
              ),
              SizedBox(height: height * 0.2),
              Container(
                width: width * 0.9,
                child: FadingSlidingWidget(
                  animationController: _animationController,
                  interval: const Interval(0.7, 1.0),
                  child: Text(
                    "Among the first to be interceded for by the Prophet ﷺ are those who sent most salah upon him, and the best day to send salah upon him ﷺ is Friday",
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: width * 0.056,
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

class FadingSlidingWidget extends StatelessWidget {
  const FadingSlidingWidget({
    @required AnimationController animationController,
    @required this.child,
    this.interval = const Interval(0.5, 1.0),
  }) : _animationController = animationController;

  final AnimationController _animationController;
  final Widget child;
  final Interval interval;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animationController.drive(
        Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero).chain(
          CurveTween(curve: interval),
        ),
      ),
      child: FadeTransition(
        opacity: _animationController.drive(
          Tween<double>(begin: 0.0, end: 1.0).chain(
            CurveTween(curve: interval),
          ),
        ),
        child: child,
      ),
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
    return Container(
      padding: EdgeInsets.only(top: height * 0.15),
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
            width: width * 0.9,
          ),
          SizedBox(height: height * 0.1),
          Flexible(
            child: FadingSlidingWidget(
              animationController: _animationController,
              interval: const Interval(0.2, 0.5),
              child: Text(
                widget.onBoardPageItem.text,
                style: TextStyle(fontSize: width * 0.05),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
