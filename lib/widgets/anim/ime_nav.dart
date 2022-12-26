import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class IMENav extends StatefulWidget {
  const IMENav({required this.child});

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
            return PageTransitionSwitcher(
              transitionBuilder: (child, anim, secAnim) {
                return FadeThroughTransition(
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  secondaryAnimation: secAnim,
                  animation: anim,
                  child: child,
                );
              },
              child: widget.child,
            );
          },
          settings: settings,
        );
      },
    );
  }
}
