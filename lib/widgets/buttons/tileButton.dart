import 'dart:ui';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/implicit_animations.dart';
import '../anim/anim.dart';

class SettingsLinkButton extends StatefulWidget {
  final String? title, subtitle;

  const SettingsLinkButton({Key? key, this.title, this.subtitle}) : super(key: key);

  @override
  State<SettingsLinkButton> createState() => _SettingsLinkButtonState();
}

class _SettingsLinkButtonState extends State<SettingsLinkButton> {
  bool _isMouseOver = false;

  set isOver(bool value) {
    if (value == _isMouseOver) return;
    setState(() => _isMouseOver = value);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = isDisplayDesktop(context);
    final theme = Theme.of(context).textTheme.button!.copyWith(
        fontSize: isDesktop ? size.width * .025 : size.width * .08,
        letterSpacing: .5,
        color: _isMouseOver ? Theme.of(context).primaryColor : null,
        fontFamily: context.isDarkMode ? 'Roboto' : 'Amiri',
        fontWeight: FontWeight.w100);

    return WidgetAnimator(MouseRegion(
      opaque: false,
      cursor: SystemMouseCursors.click,
      onEnter: (_) => isOver = true,
      onHover: (_) => isOver = true,
      onExit: (_) => isOver = false,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedScale(
            duration: Duration(milliseconds: 5000),
            curve: Curves.easeIn,
            scale: _isMouseOver ? 2 : 1.1,
            child: Image.asset(
              widget.title!,
              fit: BoxFit.fitHeight,
              width: size.width,
              matchTextDirection: true,
              height: size.height,
            ),
          ),
          Center(child: Text(widget.subtitle!, style: theme)),
          Positioned(
            child: Container(
              height: size.height * .4,
              width: size.width * .4,
                color: Colors.transparent
            ),
          ),
        ],
      ),
    ));
  }
}

class DesktopButton extends StatefulWidget {
  final Widget? openC;
  final String? title,subtitle;

  const DesktopButton({Key? key, this.openC, this.title, this.subtitle}) : super(key: key);

  @override
  State<DesktopButton> createState() => _DesktopButtonState();
}

class _DesktopButtonState extends State<DesktopButton> {
  bool _isMouseOver = false;

  set isOver(bool value) {
    if (value == _isMouseOver) return;
    setState(() => _isMouseOver = value);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = isDisplayDesktop(context);
    final theme = Theme.of(context).textTheme.button!.copyWith(
        fontSize: isDesktop ? size.width * .025 : size.width * .08,
        letterSpacing: .5,
        color: _isMouseOver ? Theme.of(context).primaryColor : null,
        fontFamily: context.isDarkMode ? 'Roboto' : 'Amiri',
        fontWeight: FontWeight.w100);
    return WidgetAnimator(
      MouseRegion(
        opaque: false,
        cursor: SystemMouseCursors.click,
        onEnter: (_) => isOver = true,
        onHover: (_) => isOver = true,
        onExit: (_) => isOver = false,
        child: Container(
          height: _isMouseOver ? size.height * .07 : size.height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(_isMouseOver ? 50 : 20)),
          width: _isMouseOver ? size.width * .05 : size.width,
          child: OpenContainer<bool>(
            closedElevation: .0,
            closedColor: Colors.transparent,
            openElevation: .0,
            transitionType: ContainerTransitionType.fade,
            openBuilder: (context, openContainer) => widget.openC!,
            closedBuilder: (context, openContainer) => AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    reverseDuration: Duration(milliseconds: 1000),
                    transitionBuilder: (Widget child, Animation<double> animation) =>
                        ScaleTransition(child: child, scale: animation),
                    child: _isMouseOver
                        ? Container(
                      height: isDesktop ? size.height * .27 : size.height * .18,
                      width: isDesktop ? size.width * .15 : size.width * .35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: AssetImage(widget.title!),
                            fit: BoxFit.fitHeight,
                            matchTextDirection: true,
                          )),
                      child: Center(child: Text(widget.subtitle!, style: theme)),
                    )
                        : SettingsLinkButton(title: widget.title, subtitle: widget.subtitle)),
          ),
        ),
      ),
    );
  }
}

class TitleHeader extends StatelessWidget {
  final String? text;

  const TitleHeader({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WidgetAnimator(
      Container(
        child: Column(
          children: [
            Text(text!,
                style: theme.primaryTextTheme.subtitle1!.copyWith(
                    color: context.isDarkMode ? null : theme.primaryColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 17,
                    letterSpacing: 2)),
          ],
        ),
        padding: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? theme.highlightColor
              : theme.primaryColorLight.withOpacity(.2),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
