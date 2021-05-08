import 'package:flutter/cupertino.dart';
import 'package:islam_made_easy/utils/device_info.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';
import 'package:islam_made_easy/widgets/page_decoration.dart';

ContainerTransitionType _transitionType = ContainerTransitionType.fade;

class DetailsPage extends StatefulWidget {
  final List<Widget> data;
  final String title;
  final String barTitle;
  final String image;

  const DetailsPage({
    Key key,
    @required this.data,
    @required this.title,
    @required this.barTitle,
    @required this.image,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  void _showSnackBarOnCopyFailure(Object exception) {
    Get.snackbar(S.current.copyError, exception);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  static DelayUI shareDelay = DelayUI(Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDesktop = isDisplayDesktop(context);
    final theme = Theme.of(context);
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    final size = context.mediaQuery.size;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(widget.barTitle),
        elevation: 0,
        leading: isDesktop
            ? null
            : IconButton(
                icon: FaIcon(ar
                    ? FontAwesomeIcons.angleRight
                    : FontAwesomeIcons.angleLeft),
                onPressed: Get.back,
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              ),
        actions: [
          IconButton(
              icon: FaIcon(
                PixIcon.pix_copy,
                color: Colors.greenAccent.withOpacity(0.4),
              ),
              tooltip: MaterialLocalizations.of(context).copyButtonLabel,
              onPressed: () {
                HapticFeedback.heavyImpact();
                Clipboard.setData(
                  ClipboardData(text: widget.title),
                )
                    .then(
                      (value) => Get.snackbar(S.current.copiedToClipboardTitle,
                          S.current.copiedToClipboard),
                    )
                    .catchError(_showSnackBarOnCopyFailure);
              }),
          DeviceOS.isMobile
              ? IconButton(
                  icon: FaIcon(FontAwesomeIcons.shareAlt),
                  onPressed: () {
                    shareDelay.run(
                      () => Share.share(
                          "${widget.title} \nIslam Made Easy\n${S.current.aboutApp}",
                          subject: ShareUtil().getPlatformShare()),
                    );
                  },
                )
              : Container(),
        ],
      ),
      body: Stack(
        children: [
          GradientCircles(),
          CupertinoScrollbar(
            isAlwaysShown: true,
            controller: controller,
            child: ListView(
              controller: controller,
              padding: EdgeInsets.symmetric(
                  horizontal: isDesktop || context.isTablet ? 30 : 10,
                  vertical: isDesktop || context.isTablet ? 20 : 10),
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 40.0,
                      left: ar ? 120 : 0,
                      right: ar ? 0 : 120,
                      child: Container(
                        height: 30.0,
                        width: 170.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight:
                                  ar ? Radius.zero : Radius.elliptical(10, 50),
                              topLeft:
                                  ar ? Radius.elliptical(50, 20) : Radius.zero),
                          gradient: LinearGradient(
                            colors: [
                              theme.accentColor,
                              theme.backgroundColor,
                            ],
                            tileMode: TileMode.mirror,
                            end: ar ? Alignment.topLeft : Alignment.topRight,
                            begin: ar
                                ? Alignment.bottomRight
                                : Alignment.bottomLeft,
                            stops: [0.0, 1.0],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(
                            colors: [theme.accentColor, theme.backgroundColor],
                            tileMode: TileMode.mirror,
                            end: ar ? Alignment.topLeft : Alignment.topRight,
                            begin: ar
                                ? Alignment.bottomRight
                                : Alignment.bottomLeft,
                            stops: [0.0, 1.0],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 75.0,
                      left: ar ? 0 : 200,
                      right: ar ? 200 : 0,
                      child: Container(
                        height: 120.0,
                        width: 140.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    ar ? Radius.zero : Radius.circular(10),
                                topLeft: ar ? Radius.zero : Radius.circular(10),
                                topRight: ar
                                    ? Radius.elliptical(50, 20)
                                    : Radius.zero),
                            gradient: LinearGradient(
                              colors: [
                                theme.accentColor,
                                theme.backgroundColor
                              ],
                              tileMode: TileMode.mirror,
                              begin:
                                  ar ? Alignment.topRight : Alignment.topLeft,
                              end: ar
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              stops: [0.0, 1.0],
                            ),
                            shape: BoxShape.rectangle),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        gradient: LinearGradient(
                          colors: [
                            theme.primaryColorDark,
                            theme.backgroundColor,
                          ],
                          tileMode: TileMode.mirror,
                          end: ar ? Alignment.topLeft : Alignment.topRight,
                          begin:
                              ar ? Alignment.bottomRight : Alignment.bottomLeft,
                          stops: [0.0, 1.0],
                        ),
                        color:
                            theme.colorScheme.secondaryVariant.withOpacity(0.5),
                      ),
                      // color: Color(0xFFF2F2F2),

                      height: size.height * 0.36,
                      width: size.width - 10,
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset(
                          widget.image,
                          fit: BoxFit.cover,
                          matchTextDirection: true,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                SelectableText(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: textTheme.headline5.copyWith(
                    color: Colors.black54,
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.data,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    this.closedBuilder,
    @required this.data,
    @required this.title,
    @required this.barTitle,
    @required this.image,
  });

  final CloseContainerBuilder closedBuilder;
  final List<Widget> data;
  final String title;
  final String barTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      OpenContainer<bool>(
        transitionType: _transitionType,
        openBuilder: (context, openContainer) => DetailsPage(
            title: title, data: data, barTitle: barTitle, image: image),
        tappable: false,openColor: Theme.of(context).backgroundColor,
        closedBuilder: closedBuilder,
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    this.openContainer,
    @required this.title,
    this.subTitle,
    @required this.img,
    this.details,
  });

  final String title;
  final String img;
  final String details;
  final String subTitle;
  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final isDesktop = isDisplayDesktop(context);
    final ar = locale.languageCode == 'ar';
    final size = context.mediaQuery.size;
    final theme = Theme.of(context);
    return SizedBox(
      height: size.height * 0.45,
      child: InkWell(
        onTap: openContainer,
        child: LayoutBuilder(
          builder: (context, constraints) => ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 40.0,
                          left: ar ? 120 : 0,
                          right: ar ? 0 : 120,
                          child: Container(
                            height: 30.0,
                            width: 170.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: ar
                                      ? Radius.zero
                                      : Radius.elliptical(10, 50),
                                  topLeft: ar
                                      ? Radius.elliptical(50, 20)
                                      : Radius.zero),
                              gradient: LinearGradient(
                                colors: [
                                  theme.accentColor,
                                  theme.backgroundColor
                                ],
                                tileMode: TileMode.mirror,
                                end:
                                    ar ? Alignment.topLeft : Alignment.topRight,
                                begin: ar
                                    ? Alignment.bottomRight
                                    : Alignment.bottomLeft,
                                stops: [0.0, 1.0],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10.0,
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              gradient: LinearGradient(
                                colors: [
                                  theme.accentColor,
                                  theme.backgroundColor
                                ],
                                tileMode: TileMode.mirror,
                                end:
                                    ar ? Alignment.topLeft : Alignment.topRight,
                                begin: ar
                                    ? Alignment.bottomRight
                                    : Alignment.bottomLeft,
                                stops: [0.0, 1.0],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 75.0,
                          left: ar ? 0 : 200,
                          right: ar ? 200 : 0,
                          child: Container(
                            height: 120.0,
                            width: 140.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft:
                                        ar ? Radius.zero : Radius.circular(10),
                                    topLeft:
                                        ar ? Radius.zero : Radius.circular(10),
                                    topRight: ar
                                        ? Radius.elliptical(50, 20)
                                        : Radius.zero),
                                gradient: LinearGradient(
                                  colors: [
                                    theme.accentColor,
                                    theme.backgroundColor
                                  ],
                                  tileMode: TileMode.mirror,
                                  begin: ar
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  end: ar
                                      ? Alignment.bottomLeft
                                      : Alignment.bottomRight,
                                  stops: [0.0, 1.0],
                                ),
                                shape: BoxShape.rectangle),
                          ),
                        ),
                        Container(
                          color: theme.hoverColor,
                          child: Center(
                            child: Image.asset(
                              img,
                              fit: BoxFit.cover,
                              matchTextDirection: true,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: isDesktop || context.isTablet ? 21 : 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
