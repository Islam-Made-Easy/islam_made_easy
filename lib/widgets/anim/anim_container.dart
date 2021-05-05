import 'package:flutter/material.dart';

import 'fade_slide.dart';

class AnimContainer extends StatefulWidget {
  final Widget child;
  final BoxDecoration decoration;
  final double height;
  final double width;
final AlignmentGeometry alignment;
  const AnimContainer({Key key, this.child, this.decoration, this.height, this.width, this.alignment}) : super(key: key);
  @override
  _AnimContainerState createState() => _AnimContainerState();
}

class _AnimContainerState extends State<AnimContainer> with SingleTickerProviderStateMixin{
  AnimationController _animController;

  @override
  void initState() {
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
    super.initState();
  }
  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FadingSlidingWidget(animationController: _animController,child: AnimatedContainer(duration: const Duration(seconds: 1),
      child: widget.child,decoration: widget.decoration,height: widget.height,width: widget.width,alignment: widget.alignment,));
  }
}
