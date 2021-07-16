import 'package:flutter/material.dart';

class FadingSlidingWidget extends StatelessWidget {
  const FadingSlidingWidget(
      {AnimationController anim, this.child, this.interval = const Interval(0.5, 1.0)})
      : _anim = anim;

  final AnimationController _anim;
  final Widget child;
  final Interval interval;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _anim.drive(
        Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero).chain(CurveTween(curve: interval)),
      ),
      child: FadeTransition(
        opacity: _anim.drive(
          Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: interval)),
        ),
        child: child,
      ),
    );
  }
}