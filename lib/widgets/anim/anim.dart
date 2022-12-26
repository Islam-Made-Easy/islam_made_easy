import 'dart:async';
import 'package:flutter/material.dart';

class Animator extends StatefulWidget {
  final Widget child;
  final Duration time;

  Animator(this.child, this.time);

  @override
  _AnimatorState createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator>
    with SingleTickerProviderStateMixin {
  late Timer timer;
  late AnimationController anim;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    anim =
        AnimationController(duration: Duration(milliseconds: 290), vsync: this);
    animation = CurvedAnimation(parent: anim, curve: Curves.easeInOut);
    timer = Timer(widget.time, anim.forward);
  }

  @override
  void dispose() {
    anim.dispose();
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(.0, (1 - animation.value) * 20),
            child: child,
          ),
        );
      },
    );
  }
}

Timer? timer;
Duration duration = Duration();

wait() {
  if (timer == null || !timer!.isActive) {
    timer = Timer(Duration(microseconds: 120), () => duration = Duration());
  }
  duration += Duration(milliseconds: 100);
  return duration;
}

class WidgetAnimator extends StatelessWidget {
  final Widget child;

  WidgetAnimator(this.child);

  @override
  Widget build(BuildContext context) {
    return Animator(child, wait());
  }
}
