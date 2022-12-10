import 'package:islam_made_easy/views/QnA/qna.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.data,
    required this.onTap,
  }) : super(key: key);
  final String data;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: data,
        textStyle: TextStyle(color: Colors.white),
        child: FaIcon(icon, color: Get.theme.primaryColor),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(.4),
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),
    );
  }
}
