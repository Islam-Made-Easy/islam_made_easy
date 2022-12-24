import 'package:islam_made_easy/views/QnA/qna.dart';

class ShareButtons extends StatelessWidget {
  final String? tip;
  final IconData? icon;
  final void Function() onPressed;
  final Color? color;

  const ShareButtons(
      {Key? key, this.color, this.icon, required this.onPressed, this.tip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return WidgetAnimator(
      Container(
        padding: EdgeInsets.all(isDesktop ? 10 : 0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              offset: Offset(4.0, 4.0),
              blurRadius: isDesktop ? 10 : 2,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: color!.withOpacity(.09),
              offset: Offset(-4.0, -4.0),
              blurRadius: isDesktop ? 10 : 2,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.transparent.withOpacity(.09),
              offset: Offset(-4.0, -4.0),
              blurRadius: isDesktop ? 10 : 2,
              spreadRadius: 1.0,
            ),
          ],
          gradient: gradient,
        ),
        child: Tooltip(
          message: tip!,
          decoration: BoxDecoration(
            color: color!.withOpacity(.4),
            borderRadius: BorderRadius.all(Radius.circular(isDesktop ? 14 : 7)),
          ),
          child: IconButton(
            icon: FaIcon(icon!),
            splashRadius: isDesktop ? 40 : 20,
            hoverColor: color!.withOpacity(.04),
            color: color,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}

LinearGradient get gradient => LinearGradient(colors: [
      Colors.grey[100]!,
      Colors.grey[200]!,
      Colors.grey[300]!,
      Colors.grey[400]!,
    ], stops: [
      .0,
      .3,
      .8,
      1.0,
    ], begin: Alignment.topLeft, end: Alignment.bottomLeft);
