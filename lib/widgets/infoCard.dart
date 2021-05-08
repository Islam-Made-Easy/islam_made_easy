import 'package:islam_made_easy/views/QnA/qna.dart';

import 'anim/anim.dart';

class InfoCard extends StatefulWidget {
  final String quest;
  final List<Widget> answers;

  const InfoCard({Key key, @required this.quest, @required this.answers})
      : super(key: key);

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  void _showSnackBarOnCopyFailure(Object exception) {
    Get.snackbar(S.current.copyError, exception);
  }

  static DelayUI shareDelay = DelayUI(Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return WidgetAnimator(
      Card(
        shape: isDesktop || context.isTablet
            ? Border(
                left: BorderSide(color: Colors.grey[300], width: 5),
                bottom: BorderSide(color: Colors.grey[400], width: 5),
                top: BorderSide(color: Colors.grey[400], width: 2),
                right: BorderSide(color: Colors.grey[500], width: 3),
              )
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 0,
        // color: Theme.of(context).splashColor,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shadowColor: Colors.grey,
        child: ExpansionTile(
          // backgroundColor: Theme.of(context).splashColor,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: FaIcon(
                  PixIcon.pix_copy,
                  color: Colors.greenAccent.withOpacity(0.4),
                ),
                splashRadius: 10,
                tooltip: MaterialLocalizations.of(context).copyButtonLabel,
                onPressed: () => Clipboard.setData(
                  ClipboardData(text: widget.quest),
                )
                    .then(
                      (value) => Get.snackbar(S.current.copiedToClipboardTitle,
                          S.current.copiedToClipboard),
                    )
                    .catchError(_showSnackBarOnCopyFailure),
              ),
              DeviceOS.isMobile
                  ? IconButton(
                      icon: FaIcon(FontAwesomeIcons.shareAlt, size: 20),
                      splashRadius: 10,
                      onPressed: () => shareDelay.run(() => Share.share(
                          "Get Quizzes, Questions and more from: https://islamadeasy.page.link/share",
                          subject: '𝗤. ${widget.quest}')),
                    )
                  : Container()
            ],
          ),
          expandedAlignment: Alignment.topCenter,
          tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          childrenPadding: EdgeInsets.symmetric(
              vertical: isDesktop || context.isTablet ? 20 : 10,
              horizontal: isDesktop || context.isTablet ? 30 : 10),
          title: Text(
            "𝗤. ${widget.quest}",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 17, fontFamily: 'Amiri', letterSpacing: 0.1),
          ),
          children: widget.answers,
        ),
      ),
    );
  }
}
