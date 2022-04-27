import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';

class StretchButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool primary;

  StretchButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.primary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? background = Theme.of(context).buttonColor;
    var foreground = Theme.of(context).primaryTextTheme.bodyText2!.color;
    if (primary) {
      var temp = background;
      background = foreground;
      foreground = temp;
    }
    final border = primary
        ? BorderSide.none
        : BorderSide(color: foreground!.withOpacity(.5), width: .5);
    return WidgetAnimator(
      TextButton(
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 20, fontFamily: 'Quicksand'),
        ),
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
              side: border, borderRadius: BorderRadius.circular(5)),
          primary: Theme.of(context).buttonColor,
          textStyle: Theme.of(context)
              .textTheme
              .button!
              .copyWith(fontFamily: 'Quicksand', letterSpacing: 2),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: onTap,
      ),
    );
  }
}
