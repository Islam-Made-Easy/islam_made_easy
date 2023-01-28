import 'package:vector_math/vector_math.dart' as radians;

import '../../views/QnA/qna.dart';

class CatMenu extends StatefulWidget {
  const CatMenu({Key? key}) : super(key: key);

  @override
  State<CatMenu> createState() => _CatMenuState();
}

class _CatMenuState extends State<CatMenu> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RadianAnime();
  }
}

class RadianAnime extends StatefulWidget {
  RadianAnime({
    Key? key,
  }) : super(key: key);

  @override
  State<RadianAnime> createState() => _RadianAnimeState();
}

class _RadianAnimeState extends State<RadianAnime>
    with TickerProviderStateMixin {
  late final Animation<double> scale;
  late final Animation<double> rotation;
  late final Animation<double> translation;
  late final AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    scale = Tween<double>(begin: 1.5, end: .0).animate(
      CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
    );
    translation = Tween<double>(begin: .0, end: 100.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    );
    rotation = Tween<double>(begin: .0, end: 360.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(.0, .7, curve: Curves.decelerate),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, builder) {
          return Stack(
            alignment: Alignment.center,
            children: [
              _buttons(340,
                  color: Colors.yellowAccent,
                  icon: FontAwesomeIcons.a,
                  tip: 'Match Up'),
              _buttons(35,
                  color: Colors.greenAccent,
                  icon: FontAwesomeIcons.b,
                  tip: 'True or False'),
              _buttons(90,
                  color: Colors.blueAccent,
                  icon: FontAwesomeIcons.c,
                  tip: 'Multiple Choice'),
              _buttons(145,
                  color: Colors.redAccent,
                  icon: FontAwesomeIcons.d,
                  tip: 'Fill in the Blank'),
              _buttons(200,
                  color: Colors.pinkAccent,
                  icon: FontAwesomeIcons.e,
                  tip: 'Find the Mistake'),
              _buttons(270,
                  color: Colors.purpleAccent,
                  icon: FontAwesomeIcons.f,
                  tip: 'Sequence Order'),
              Transform.scale(
                scale: scale.value - 1.5,
                child: _activeTile(onTap: _close),
              ),
              Transform.scale(
                scale: scale.value,
                child: _activeTile(onTap: _open),
              ),
            ],
          );
        });
  }
  bool _isMouseOver = false;

  set isOver(bool value) {
    if (value == _isMouseOver) return;
    setState(() => _isMouseOver = value);
  }

  _buttons(double angle,
      {required Color color, required IconData icon, required String tip}) {
    final double rad = radians.radians(angle);
    return Transform.rotate(
      angle: radians.radians(rotation.value),
      child: Transform(
        transform: Matrix4.identity()
          ..translate(
            (translation.value) * cos(rad),
            (translation.value) * sin(rad),
          ),
        child: MouseRegion(
          opaque: false,
          cursor: SystemMouseCursors.click,
          onEnter: (_) => isOver = true,
          onHover: (_) => isOver = true,
          onExit: (_) => isOver = false,
          child: GestureDetector(
            onTap: _open,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor),
                gradient: RadialGradient(colors: [
                  Color(0xffffe598).withOpacity(.5),
                  Color(0xff2934BE).withOpacity(.5),
                  Color(0xFF5F79F4).withOpacity(.5),
                  Color(0x95AC25FF).withOpacity(.5)
                ]),
              ),
              height: 50,
              width: 50,
              child: Tooltip(
                verticalOffset: 50,
                message: tip,
                textAlign: TextAlign.justify,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  reverseDuration: Duration(milliseconds: 1000),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) =>
                          ScaleTransition(child: child, scale: animation),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(_isMouseOver?-2.0:-4.0, _isMouseOver?-2.0:2.0),
                        ),
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(_isMouseOver?0.5:.8),
                          offset: Offset(_isMouseOver?0:-4.0, _isMouseOver?0:-4.0),
                          blurRadius: _isMouseOver?5:10,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Colors.transparent.withOpacity(_isMouseOver?0.5:.9),
                          offset: Offset(_isMouseOver?-2.0:-4.0, _isMouseOver?-2.0:-4.0),
                          blurRadius: _isMouseOver?5:10,
                          spreadRadius: _isMouseOver?2:1.0,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: _close,
                      color: color.withOpacity(_isMouseOver?0.2:.5),
                      icon: FaIcon(icon),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }

  Widget _activeTile({void Function()? onTap}) {
    return WidgetAnimator(
      GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/images/sense.png'),
                colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColor,
                  BlendMode.modulate,
                ),
                fit: BoxFit.fill,
                repeat: ImageRepeat.repeatY,
              ),
              border: Border.all(color: Theme.of(context).primaryColor),
              boxShadow: [
                BoxShadow(
                  offset: Offset(-4.0, 2.0),
                ),
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(.8),
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 10,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                  color: Colors.transparent.withOpacity(.9),
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 10,
                  spreadRadius: 1.0,
                ),
              ],
              gradient: RadialGradient(colors: [
                Color(0xffffe598).withOpacity(.5),
                Color(0xff2934BE).withOpacity(.5),
                Color(0xFF5F79F4).withOpacity(.5),
                Color(0x95AC25FF).withOpacity(.5)
              ])),
          height: 80,
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tawheed and Shirk',
                style: Theme.of(context).textTheme.button!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
