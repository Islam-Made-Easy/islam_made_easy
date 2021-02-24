import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class IMENav extends StatefulWidget {
  const IMENav({@required this.child}) : assert(child != null);
  final Widget child;

  @override
  _IMENavState createState() => _IMENavState();
}

class _IMENavState extends State<IMENav> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(
          builder: (context) {
            return FadeThroughTransitionSwitcher(
              fillColor: Theme.of(context).backgroundColor,
              child: widget.child,
            );
          },
          settings: settings,
        );
      },
    );
  }
}

class FadeThroughTransitionSwitcher extends StatelessWidget {
  const FadeThroughTransitionSwitcher(
      {@required this.fillColor, @required this.child})
      : assert(fillColor != null),
        assert(child != null);

  final Widget child;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (child, animation, secondaryAnimation) {
        return FadeThroughTransition(
          fillColor: fillColor,
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
        );
      },
      child: child,
    );
  }
}
