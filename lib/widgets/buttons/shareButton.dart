import 'package:islam_made_easy/views/QnA/qna.dart';

class ShareButtons extends StatelessWidget {
  final String? tip;
  final Widget? icon;
  final Function? onPressed;

  const ShareButtons({Key? key, this.icon, this.onPressed, this.tip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Container(
      padding: EdgeInsets.all(isDesktop?10:0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.grey[300]!, offset: Offset(4.0, 4.0), blurRadius: isDesktop?10:2, spreadRadius: 1.0),
          BoxShadow(color: Colors.transparent.withOpacity(.09), offset: Offset(-4.0, -4.0), blurRadius:  isDesktop?10:2, spreadRadius: 1.0),
        ],
        gradient: gradient,
      ),
      child: InkWell(child: Tooltip(message: tip!,child: icon,textStyle: Theme.of(context).textTheme.button!.copyWith(fontFamily: 'Roboto',fontWeight: FontWeight.w100)),onTap: onPressed as void Function()?),
    );
  }
}
LinearGradient get gradient => LinearGradient(colors: [
  Colors.grey[100]!, Colors.grey[200]!, Colors.grey[300]!, Colors.grey[400]!,
], stops: [.0, .3, .8, 1.0], begin: Alignment.bottomLeft, end: Alignment.topRight);