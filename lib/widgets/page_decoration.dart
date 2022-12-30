import 'package:flutter/physics.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';

class GradientCircles extends StatefulWidget {
  @override
  State<GradientCircles> createState() => _GradientCirclesState();
}

class _GradientCirclesState extends State<GradientCircles>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllers;
  GravitySimulation _gravitySimulation =
      GravitySimulation(700.0, -60.0, 410.0, .0);
  late AnimationController controller;
  late Animation _animation;
  late Animation _animation1;
  late Animation _animation2;
  late Animation _animation3;
  Duration duration = Duration(seconds: 5);
  Duration _duration = Duration(seconds: 10);

  @override
  void initState() {
    _controllers = AnimationController.unbounded(vsync: this);
    _controller = AnimationController(vsync: this, duration: duration);
    controller = AnimationController(vsync: this, duration: _duration);
    _animation = Tween(begin: .05, end: 450).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(.40, .60, curve: Curves.easeInExpo)));
    _animation3 = Tween(begin: .0, end: 450).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(.0, .40, curve: Curves.easeInCirc)));
    _animation1 = Tween(begin: .0, end: 400).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(.20, .40, curve: Curves.easeInCirc)));
    _animation2 = Tween(begin: .0, end: 450).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(.10, .50, curve: Curves.easeInCubic)));
    _controller.forward();
    controller.forward();
    _controllers.animateWith(_gravitySimulation);
    _controller.addListener(() => setState(() {}));
    _controllers.addListener(() => setState(() {}));
    controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final size = MediaQuery.of(context).size;
    final ar = locale.languageCode == 'ar';
    final theme = Theme.of(context);
    var blackGradient = LinearGradient(
        colors: [theme.primaryColor, const Color(0xFFA629CC)],
        begin: Alignment.bottomLeft,
        tileMode: TileMode.decal,
        end: Alignment.topRight,
        stops: [0.0, 1.0]);
    var violetGradient = LinearGradient(
        colors: [const Color(0xFF4884E7), theme.primaryColor],
        begin: Alignment.bottomLeft,
        tileMode: TileMode.mirror,
        end: Alignment.topRight,
        stops: [0.0, 1.0]);
    var thodGradient = LinearGradient(
        colors: [theme.primaryColor, const Color(0xFF5F79F4)],
        begin: Alignment.bottomLeft,
        tileMode: TileMode.mirror,
        end: Alignment.topRight,
        stops: [0.0, 1.0]);
    var skyBlueGradient = LinearGradient(
        colors: [Color(0xffffe598).withOpacity(.5), theme.primaryColor],
        begin: Alignment.bottomLeft,
        tileMode: TileMode.mirror,
        end: Alignment.topRight,
        stops: [0.0, 1.0]);
    var blackBlueGradient = LinearGradient(
        colors: [Colors.blueGrey.shade800, theme.primaryColor],
        end: Alignment.bottomRight,
        tileMode: TileMode.mirror,
        begin: Alignment.topLeft,
        stops: [0.0, 1.0]);
    var yellowOrangeGradient = LinearGradient(
      colors: [theme.primaryColor, const Color(0xFF5F79F4)],
      begin: Alignment.bottomRight,
      tileMode: TileMode.mirror,
      end: Alignment.topLeft,
      stops: [0.0, 1.0],
    );

    return Stack(
      children: [
        Positioned(
          top: -75.0,
          right: 85.0,
          child: Container(
            width: 140.0,
            height: _animation3.value + 10.0,
            decoration: BoxDecoration(
              gradient: yellowOrangeGradient,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: -115.0,
          right: ar ? -195 : 160,
          left: ar ? 140 : -195.0,
          child: Opacity(
            opacity: .05,
            child: AnimatedContainer(
              height: _animation.value + 10.0,
              decoration: BoxDecoration(
                  color: theme.colorScheme.secondary, shape: BoxShape.circle),
              duration: Duration(milliseconds: 300),
            ),
          ),
        ),
        Positioned(
          top: 775.0,
          left: -75.0,
          child: AnimatedContainer(
            height: 150.0,
            width: 150.0,
            decoration: BoxDecoration(
                gradient: blackBlueGradient, shape: BoxShape.circle),
            duration: Duration(milliseconds: 300),
          ),
        ),
        Positioned(
          right: -7.0,
          top: 620.0,
          child: AnimatedContainer(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                gradient: yellowOrangeGradient, shape: BoxShape.circle),
            duration: Duration(milliseconds: 300),
          ),
        ),
        Positioned(
          top: size.height * .2,
          left: ar ? 0 : size.width * .3,
          right: ar ? size.width * .3 : -100,
          child: Opacity(
            opacity: .05,
            child: AnimatedContainer(
              height: _animation1.value + 10.0,
              decoration: BoxDecoration(
                  color: theme.colorScheme.secondary, shape: BoxShape.circle),
              duration: Duration(milliseconds: 300),
            ),
          ),
        ),
        Positioned(
          left: 325.0,
          top: 845.0,
          child: AnimatedContainer(
            height: 25.0,
            width: 25.0,
            decoration:
                BoxDecoration(gradient: violetGradient, shape: BoxShape.circle),
            duration: Duration(milliseconds: 300),
          ),
        ),
        Positioned(
          left: 65.0,
          top: 575.0,
          child: AnimatedContainer(
            height: 25.0,
            width: 25.0,
            decoration:
                BoxDecoration(gradient: thodGradient, shape: BoxShape.circle),
            duration: Duration(milliseconds: 300),
          ),
        ),
        Positioned(
          right: -7.0,
          top: 245.0,
          child: AnimatedContainer(
            height: 150.0,
            width: 150.0,
            decoration:
                BoxDecoration(gradient: blackGradient, shape: BoxShape.circle),
            duration: Duration(milliseconds: 300),
          ),
        ),
        Positioned(
          bottom: 0,
          left: ar ? 0 : null,
          right: ar ? null : 0,
          child: Opacity(
            opacity: .06,
            child: AnimatedContainer(
              height: 80.0,
              width: _animation2.value + 10.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.elliptical(80, 20),
                ),
                color: theme.colorScheme.secondary,
                shape: BoxShape.rectangle,
              ),
              duration: Duration(milliseconds: 300),
            ),
          ),
        ),
        Positioned(
          left: _animation3.value + 50.0,
          top: _controllers.value,
          child: AnimatedContainer(
            height: _animation3.value + 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              gradient: skyBlueGradient,
              shape: BoxShape.circle,
            ),
            duration: Duration(milliseconds: 300),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllers.dispose();
    controller.dispose();
    super.dispose();
  }
}
