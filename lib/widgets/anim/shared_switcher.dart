import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisTransitionSwitcher extends StatelessWidget {
  const SharedAxisTransitionSwitcher({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (child, animation, secondaryAnimation) {
        return SharedAxisTransition(
          transitionType: SharedAxisTransitionType.scaled,
          fillColor: Theme.of(context).colorScheme.background,
          secondaryAnimation: secondaryAnimation,
          animation: animation,
          child: child,
        );
      },
      child: child,
    );
  }
}
