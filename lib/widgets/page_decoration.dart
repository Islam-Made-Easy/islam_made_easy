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
    final size = MediaQuery.of(context).size;
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    final theme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Positioned(
          top: -75.0,
          right: 85.0,
          child: Container(
            height: _animation3.value + 10.0,
            width: 140.0,
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
            child: Container(
              height: _animation.value + 10.0,
              decoration:
                  BoxDecoration(color: theme.secondary, shape: BoxShape.circle),
            ),
          ),
        ),
        Positioned(
          left: -75.0,
          top: 775.0,
          child: Container(
            height: 150.0,
            width: 150.0,
            decoration: BoxDecoration(
                gradient: blackBlueGradient, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          right: -7.0,
          top: 620.0,
          child: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                gradient: yellowOrangeGradient, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: size.height * .2,
          right: ar ? size.width * .3 : -100,
          left: ar ? 0 : size.width * .3,
          // right: ar ? -30 : 0,
          child: Opacity(
            opacity: .05,
            child: Container(
              // height: 110.0,
              height: _animation1.value + 10.0,
              decoration:
                  BoxDecoration(color: theme.secondary, shape: BoxShape.circle),
            ),
          ),
        ),
        Positioned(
          left: 325.0,
          top: 845.0,
          child: Container(
            height: 25.0,
            width: 25.0,
            decoration:
                BoxDecoration(gradient: violetGradient, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          left: 65.0,
          top: 575.0,
          child: Container(
            height: 25.0,
            width: 25.0,
            decoration:
                BoxDecoration(gradient: thodGradient, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          right: -7.0,
          top: 245.0,
          child: Container(
            height: 150.0,
            width: 150.0,
            decoration:
                BoxDecoration(gradient: blackGradient, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          bottom: 0,
          right: ar ? null : 0,
          left: ar ? 0 : null,
          child: Opacity(
            opacity: .06,
            child: Container(
              height: 80.0,
              width: _animation2.value + 10.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.elliptical(80, 20)),
                  color: theme.secondary,
                  shape: BoxShape.rectangle),
            ),
          ),
        ),
        Positioned(
          left: _animation3.value + 50.0,
          top: _controllers.value,
          child: Container(
            height: _animation3.value + 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              gradient: skyBlueGradient,
              shape: BoxShape.circle,
            ),
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

var blackGradient = LinearGradient(
    colors: [Get.theme.primaryColor, const Color(0xFFA629CC)],
    tileMode: TileMode.decal,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0]);
var violetGradient = LinearGradient(
    colors: [const Color(0xFF4884E7), Get.theme.primaryColor],
    tileMode: TileMode.mirror,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0]);
var thodGradient = LinearGradient(
    colors: [Get.theme.primaryColor, const Color(0xFF5F79F4)],
    tileMode: TileMode.mirror,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0]);
var skyBlueGradient = LinearGradient(
    colors: [Color(0xffffe598).withOpacity(.5), Get.theme.primaryColor],
    tileMode: TileMode.mirror,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0]);
var blackBlueGradient = LinearGradient(
    colors: [Colors.blueGrey.shade800, Get.theme.primaryColor],
    tileMode: TileMode.mirror,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0]);
var yellowOrangeGradient = LinearGradient(
  colors: [Get.theme.primaryColor, const Color(0xFF5F79F4)],
  tileMode: TileMode.mirror,
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
  stops: [0.0, 1.0],
);

class ScaleDetector extends StatefulWidget {
  final VoidCallback? onTap;
  final double? end;
  final Widget? child;

  const ScaleDetector({Key? key, this.onTap, this.end, this.child})
      : super(key: key);

  @override
  _ScaleDetectorState createState() => _ScaleDetectorState();
}

class _ScaleDetectorState extends State<ScaleDetector>
    with TickerProviderStateMixin {
  late AnimationController _anim;
  late Animation _scale;

  @override
  void initState() {
    modulate();
    super.initState();
  }

  void modulate() {
    _anim =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _scale = Tween(begin: 1, end: widget.end).animate(
      CurvedAnimation(parent: _anim, curve: Curves.easeInOutExpo),
    );
  }

  void playAnim() {
    _anim.forward();
    _anim.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _anim.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onTap;
        playAnim();
      },
      child: AnimatedBuilder(
        animation: _anim,
        builder: (context, child) => Transform.scale(
          scale: _scale.value * 1.1 != 1.0
              ? _scale.value * 1.1
              : _scale.value * 1.1,
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  late Random rand;
  List<Offset> circles = [];
  List<double> sizes = [];
  List<double> opacities = [];
  int seeds = 60;

  BackgroundPainter(int seed, height) {
    rand = Random(seed);
    for (int x = 0; x < seeds; x++) {
      circles.add(Offset(rand.nextInt(1.0.round()).toDouble(),
          rand.nextInt(height.round()).toDouble()));
    }
    for (int x = 0; x < seeds; x++) {
      sizes.add(rand.nextInt(.05.round()).toDouble());
    }
    for (int x = 0; x < seeds; x++) {
      opacities.add(rand.nextDouble());
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    circles.forEach((offset) {
      Paint circle = Paint()
        ..color = Colors.white.withOpacity(opacities[circles.indexOf(offset)]);
      canvas.drawCircle(offset, sizes[circles.indexOf(offset)], circle);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
