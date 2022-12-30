import 'package:islam_made_easy/views/QnA/qna.dart';

class StretchButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  StretchButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          shape: StadiumBorder(),
          backgroundColor: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: onTap,
      ),
    );
  }
}
