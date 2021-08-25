import 'package:flutter/cupertino.dart';
import 'package:islam_made_easy/utils/device_info.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';
import 'package:islam_made_easy/widgets/page_decoration.dart';

class backIndent extends Intent {}

class DetailsPage extends StatefulWidget {
  final List<Widget> data;
  final String title, barTitle, image;

  DetailsPage({Key key, this.data, this.title, this.barTitle, this.image})
      : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

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
      appBar: AppBar(
        title: Text(widget.barTitle),
        elevation: 0,
        leading: Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.arrowLeft):
            backIndent(),
          },
          child: Actions(
            actions: {
              backIndent: CallbackAction<backIndent>(
                  onInvoke: (intent) => Navigator.of(context).pop())
            },
            child: Focus(
              autofocus: true,
              child: isDesktop
                  ? BackButton()
                  : IconButton(
                    icon: FaIcon(ar ? FontAwesomeIcons.angleRight
                    : FontAwesomeIcons.angleLeft),
                onPressed: Get.back,
                tooltip:
                MaterialLocalizations.of(context).backButtonTooltip,
              ),
            ),
          ),
        ),
        actions: [
          DeviceOS.isDesktopOrWeb
              ? IconButton(
               icon: FaIcon(
                Icons.copy,
                color: Colors.greenAccent.withOpacity(.4),
              ),
              tooltip: MaterialLocalizations.of(context).copyButtonLabel,
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.title))
                    .then(
                      (value) =>
                      Get.snackbar(S.current.copiedToClipboardTitle,
                          S.current.copiedToClipboard),
                );
              }) :
          IconButton(
            icon: FaIcon(FontAwesomeIcons.shareAlt),
            onPressed: () {
              shareDelay.run(
                    () =>
                    Share.share(
                        "${widget.title} \nIslam Made Easy\n${S.current.aboutApp}",
                        subject: ShareUtil().getPlatformShare()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GradientCircles(),
          ListView(
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
                            theme.colorScheme.secondary,
                            theme.backgroundColor,
                          ],
                          tileMode: TileMode.mirror,
                          end: ar ? Alignment.topLeft : Alignment.topRight,
                          begin: ar ? Alignment.bottomRight : Alignment.bottomLeft,
                          stops: [.0, 1.0],
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
                          colors: [
                            theme.colorScheme.secondary,
                            theme.backgroundColor
                          ],
                          tileMode: TileMode.mirror,
                          end: ar ? Alignment.topLeft : Alignment.topRight,
                          begin: ar ? Alignment.bottomRight : Alignment.bottomLeft,
                          stops: [.0, 1.0],
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
                              bottomLeft: ar ? Radius.zero : Radius.circular(10),
                              topLeft: ar ? Radius.zero : Radius.circular(10),
                              topRight: ar ? Radius.elliptical(50, 20) : Radius.zero),
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.secondary,
                              theme.backgroundColor
                            ],
                            tileMode: TileMode.mirror,
                            begin: ar ? Alignment.topRight : Alignment.topLeft,
                            end: ar ? Alignment.bottomLeft : Alignment.bottomRight,
                            stops: [.0, 1.0],
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
                        begin: ar ? Alignment.bottomRight : Alignment.bottomLeft,
                        stops: [.0, 1.0],
                      ),
                      color: theme.colorScheme.primary.withOpacity(.5),
                    ),
                    height: size.height * .36,
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
                  color: theme.colorScheme.secondary,
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
        ],
      ),
    );
  }
}

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({this.closedBuilder, this.data, this.title, this.barTitle, this.image});

  final CloseContainerBuilder closedBuilder;
  final List<Widget> data;
  final String title, barTitle, image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WidgetAnimator(
      OpenContainer<bool>(
        transitionType: ContainerTransitionType.fade,
        closedElevation: 0,
        closedColor: theme.hoverColor,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        openShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        openBuilder: (context, openContainer) =>
            DetailsPage(
                title: title, data: data, barTitle: barTitle, image: image),
        tappable: false,
        openColor: theme.primaryColor,
        closedBuilder: closedBuilder,
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  const DetailsCard({this.openContainer, this.title, this.subTitle, this.img, this.details});

  final String title, img, details, subTitle;
  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final isDesktop = isDisplayDesktop(context);
    final ar = locale.languageCode == 'ar';
    final size = context.mediaQuery.size;
    final theme = Theme.of(context);
    return SizedBox(
      height: size.height * .45,
      child: InkWell(
        onTap: openContainer,
        child: LayoutBuilder(
          builder: (context, constraints) =>
              ConstrainedBox(
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
                                      theme.colorScheme.secondary,
                                      theme.backgroundColor
                                    ],
                                    tileMode: TileMode.mirror,
                                    end:
                                    ar ? Alignment.topLeft : Alignment.topRight,
                                    begin: ar
                                        ? Alignment.bottomRight
                                        : Alignment.bottomLeft,
                                    stops: [.0, 1.0],
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
                                      theme.colorScheme.secondary,
                                      theme.backgroundColor
                                    ],
                                    tileMode: TileMode.mirror,
                                    end:
                                    ar ? Alignment.topLeft : Alignment.topRight,
                                    begin: ar
                                        ? Alignment.bottomRight
                                        : Alignment.bottomLeft,
                                    stops: [.0, 1.0],
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
                                        theme.colorScheme.secondary,
                                        theme.backgroundColor
                                      ],
                                      tileMode: TileMode.mirror,
                                      begin: ar
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      end: ar
                                          ? Alignment.bottomLeft
                                          : Alignment.bottomRight,
                                      stops: [.0, 1.0],
                                    ),
                                    shape: BoxShape.rectangle),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: theme.hoverColor,
                                  image: DecorationImage(
                                    image: AssetImage(img),
                                    fit: BoxFit.cover,
                                    matchTextDirection: true,
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8))),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        tileColor: theme.primaryColor.withOpacity(.05),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))
                        ),
                        title: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline6.copyWith(
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
