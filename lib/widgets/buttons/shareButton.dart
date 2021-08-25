import 'package:islam_made_easy/views/QnA/qna.dart';

class ShareButtons extends StatelessWidget {
  final String? tip;
  final Color? color;
  final IconData? icon;
  final Function? onPressed;

  const ShareButtons({Key? key, this.color, this.icon, this.onPressed, this.tip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Container(
      padding: EdgeInsets.all(isDesktop?10:0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(color: Colors.grey[300]!, offset: Offset(4.0, 4.0), blurRadius: isDesktop?10:2, spreadRadius: 1.0),
          BoxShadow(color: color!.withOpacity(.09), offset: Offset(-4.0, -4.0), blurRadius:  isDesktop?10:2, spreadRadius: 1.0),
        ],
        gradient: gradient,
      ),
      child: IconButton(
        icon: FaIcon(icon, color: color),
        onPressed: onPressed as void Function()?, tooltip: tip, splashRadius: isDesktop ? 10 : 20,
      ),
    );
  }
}
LinearGradient get gradient => LinearGradient(colors: [
  Colors.grey[100]!, Colors.grey[200]!, Colors.grey[300]!, Colors.grey[400]!,
], stops: [.0, .3, .8, 1.0], begin: Alignment.bottomLeft, end: Alignment.topRight);