import 'package:flutter/material.dart';
import 'dart:ui';
class _AnimatedSize extends StatelessWidget {
  _AnimatedSize(
      {this.child,
      this.duration,
      this.begin,
      this.end,
      this.curve = Curves.easeOut});

  final Widget child;
  final Duration duration;
  final Size begin;
  final Size end;
  final Curve curve;

  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Size>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: begin, end: end),
      builder: (context, size, _) {
        return SizedBox(width: size.width, height: size.height, child: child);
      },
    );
  }
}

class AnimatedHeight extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double begin;
  final double end;
  final Curve curve;

  const AnimatedHeight(
      {this.child, this.duration, this.begin, this.end, this.curve, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _AnimatedSize(
      child: child,
      duration: duration,
      begin: Size(0, begin),
      end: Size(0, end),
      curve: curve,
    );
  }
}

class AnimatedWidth extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double begin;
  final double end;
  final Curve curve;

  const AnimatedWidth(
      {this.child, this.duration, this.begin, this.end, this.curve, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _AnimatedSize(
      child: child,
      duration: duration,
      begin: Size(begin, 0),
      end: Size(end, 0),
      curve: curve,
    );
  }
}

class AnimatedScale extends StatelessWidget {
  const AnimatedScale(
      {Key key, this.child, this.end, this.duration, this.begin, this.curve})
      : super(key: key);
  final Widget child;
  final Duration duration;
  final double begin;
  final double end;
  final Curve curve;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: begin ?? .2, end: end),
    curve: curve ?? Curves.easeOut,
    duration: duration,
    child: child,
    builder: (_, value, cachedChild) {
      return Transform.scale(scale: value, child: cachedChild);
    },
  );
}
