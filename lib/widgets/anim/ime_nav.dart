import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class IMENav extends StatefulWidget {
  const IMENav({this.child}) : assert(child != null);
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
              fillColor: Theme.of(context).scaffoldBackgroundColor,
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
  const FadeThroughTransitionSwitcher({this.fillColor, this.child})
      : assert(fillColor != null),
        assert(child != null);

  final Widget child;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (child, anim, secAnim) {
        return FadeThroughTransition(
          fillColor: fillColor,
          child: child,
          animation: anim,
          secondaryAnimation: secAnim,
        );
      },
      child: child,
    );
  }
}
