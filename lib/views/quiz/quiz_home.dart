
import 'package:flutter/material.dart';
import 'package:islam_made_easy/theme/themePro.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;

class QuizHome extends StatefulWidget {
  const QuizHome({Key key}) : super(key: key);

  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> fullDisplay;
    final size = MediaQuery.of(context).size;
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      appBar: AppBar(toolbarHeight: 200),
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop
                  ? 30
                  : context.isTablet
                  ? 20
                  : 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello Ahmad!", style: Theme.of(context).textTheme.button.copyWith(
                  fontSize: kSpacingUnit * 1.7,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2,
                  fontFamily: 'Roboto',
                ),),
                Text("Play and win to unlock more categories"),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: GridView(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop
                  ? 30
                  : context.isTablet
                      ? 20
                      : 16.0,
              vertical: 30.0,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: size.height * .04,
              crossAxisCount: isDesktop
                  ? 4
                  : context.isTablet
                      ? 3
                      : 2,
              crossAxisSpacing: isDesktop
                  ? 30
                  : context.isTablet
                      ? 25
                      : 12,
            ),
            children: [
              _activeTile(fullDisplay),
              _inActiveTile('Names of Allah'),
              _inActiveTile('Imaan'),
              _inActiveTile('Angels'),
              _inActiveTile('Books of Allah'),
              _inActiveTile('Prophets & Messengers'),
              _inActiveTile('Others'),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _activeTile(fullDisplay) {
    return QuizMenu(
      children: [
        QuizBtn(
            icon: Icon(FontAwesomeIcons.unity),
            buttonColor: Colors.red,
            onPress: () {
              fullDisplay = SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack,overlays: []);
            }),
        QuizBtn(
            icon: Icon(FontAwesomeIcons.feather),
            buttonColor: Colors.indigo,
            onPress: () {}),
        QuizBtn(
            icon: Icon(FontAwesomeIcons.vest),
            buttonColor: Colors.orange,
            onPress: () {}),
        QuizBtn(
            icon: Icon(FontAwesomeIcons.stream),
            buttonColor: Colors.green,
            onPress: () {}),
        QuizBtn(
            icon: Icon(FontAwesomeIcons.superpowers),
            buttonColor: Colors.pink,
            onPress: () {}),
        QuizBtn(
            icon: Icon(FontAwesomeIcons.cog),
            buttonColor: Colors.blue,
            onPress: () {}),
        QuizBtn(
            icon: Icon(FontAwesomeIcons.random),
            buttonColor: Colors.yellow,
            onPress: () {}),
        QuizBtn(
            icon: Icon(FontAwesomeIcons.digitalOcean),
            buttonColor: Colors.teal,
            onPress: () {}),
      ],
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColorDark),
        height: 80,
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/star.json',height: 100),
            Text(
              'Tawheed and Shirk',
              style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
            ),
            Divider(indent: 32, endIndent: 32, color: kGreyColor)
          ],
        ),
      ),
    );
  }

  Widget _inActiveTile(tittle) {
    return MouseRegion(
      cursor: SystemMouseCursors.forbidden,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kGreyColor.withOpacity(.3)),
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).disabledColor.withOpacity(.05)),
        height: 80,
        width: 80,
        child: Stack(
          children: [
            Center(
              child: Text(
                tittle,
                style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).disabledColor,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Roboto'),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Stack(
                  children: [
                    Positioned(
                      // bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).disabledColor.withOpacity(.5),
                          shape: BoxShape.circle,
                        ),
                        height: 50,
                        width: 30,
                      ),
                    ),
                    Positioned(
                      bottom: 18,
                      left: 10,
                      right: 10,
                      child: Container(
                          height: 15,
                          width: 7,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .highlightColor
                                  .withOpacity(.8),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  Theme.of(context).disabledColor.withOpacity(.3),
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50)),
                        height: 40,
                        width: 10,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class QuizMenu extends StatefulWidget {
  const QuizMenu({Key key,
    this.child,
    this.context,
    this.children,
    this.centerButtonSize = 0.5,
    this.centerButtonAlignment = Alignment.center}) : super(key: key);
  // will take in list of buttons
  final List<QuizBtn> children;
  final BuildContext context;
  // used for positioning the widget
  final AlignmentGeometry centerButtonAlignment;
  final Widget child;
  // set main button size
  final double centerButtonSize;
  @override
  _QuizMenuState createState() => _QuizMenuState();
}

class _QuizMenuState extends State<QuizMenu>  with SingleTickerProviderStateMixin {
  // used to control animations
  AnimationController controller;

  // controller gets initialized here
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.centerButtonAlignment,
      child: Container(
        height: 80,
        width: 80,
        child: QuizAnim(
          child: widget.child,
          controller: controller,
          radialButtons: widget.children,
          centerSizeOfButton: widget.centerButtonSize,
        ),
      ),
    );
  }
  // controller gets disposed here
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class QuizAnim extends StatelessWidget {
  QuizAnim(
      {Key key,
         this.child,
         this.controller,
         this.radialButtons,
        this.centerSizeOfButton = 0.5})
      :
  // translation animation
        translation = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.elasticOut),
        ),

  // scaling animation
        scale = Tween<double>(
          begin: centerSizeOfButton * 2,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),

  // rotation animation
        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.7,
              curve: Curves.decelerate,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> rotation;
  final Animation<double> translation;
  final Animation<double> scale;
  final List<QuizBtn> radialButtons;
  final double centerSizeOfButton;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    // will provide angle for further calculation
    double generatedAngle = 360 / (radialButtons.length);
    double iconAngle;

    return AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          return Transform.rotate(
              angle: radians(rotation.value),
              child: Stack(alignment: Alignment.center, children: [
                // generates list of buttons
                ...radialButtons.map((index) {
                  iconAngle = radialButtons.indexOf(index) * generatedAngle;
                  return _buildButton(iconAngle,
                      color: index.buttonColor,
                      icon: index.icon,
                      onPress: index.onPress);
                }),
                // secondary button animation
                // Transform.scale(
                  // scale: scale.value - (centerSizeOfButton * 2 - 0.25),
                  // child:
                  GestureDetector(onTap: close, child: child),
                // ),
                // primary button animation
                // Transform.(
                //   scale: scale.value,
                  // child:
          GestureDetector(onTap: open, child: child),
                // )
              ]));
        });
  }

  // will show child buttons
  void open() => controller.forward();


  // will hide child buttons
  void close() => controller.reverse();


  // build custom child buttons
  Widget _buildButton(double angle,
      {Function onPress, Color color, Icon icon}) {
    final double rad = radians(angle);
    return Transform(
        transform: Matrix4.identity()
          ..translate(
              (translation.value) * cos(rad), (translation.value) * sin(rad)),
        child: FloatingActionButton(
            child: icon,
            backgroundColor: color,
            onPressed: () {
              onPress();
              close();
            },
            elevation: 0));
  }
}

class QuizBtn {
  // background colour of the button surrounding the icon
  final Color buttonColor;

  // sets icon of the child buttons
  final Icon icon;

  // onPress function of the child buttons
  final Function onPress;

  // constructor for child buttons
  QuizBtn(
      {this.buttonColor = Colors.orange,
         this.icon,
         this.onPress});
}