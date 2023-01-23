import 'package:islam_made_easy/views/QnA/qna.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key, this.data, required this.icon, required this.onTap})
      : super(key: key);
  final String? data;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      IconButton(
        onPressed: onTap,
        tooltip: data,
        splashRadius: 20,
        hoverColor: Theme.of(context).primaryColor.withOpacity(.04),
        icon: FaIcon(icon, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
