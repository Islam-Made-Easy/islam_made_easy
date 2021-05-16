import 'package:islam_made_easy/views/QnA/qna.dart';

import '../anim/anim.dart';

class SettingsLinkButton extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingsLinkButton({
    Key key,
    @required this.title,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  _SettingsLinkButtonState createState() => _SettingsLinkButtonState();
}

class _SettingsLinkButtonState extends State<SettingsLinkButton>
    with SingleTickerProviderStateMixin {
  bool _isMouseOver = false;

  set isOver(bool value) {
    if (value == _isMouseOver) return;
    setState(() => _isMouseOver = value);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final isDesktop = isDisplayDesktop(context);
    return WidgetAnimator(GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        opaque: false,
        cursor: MouseCursor.defer,
        onEnter: (_) => isOver = true,
        onHover: (_) => isOver = true,
        onExit: (_) => isOver = false,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedScale(
                duration: Duration(milliseconds: 5000),
                begin: 1,
                end: 1.1,
                curve: Curves.easeIn,
                child: Image.asset(
                  widget.title,
                  fit: BoxFit.fitHeight,
                  width: size.width,
                  matchTextDirection: true,
                  height: size.height,
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 5000),
                child: Center(
                  child: isDesktop
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.subtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: size.height * 0.04,
                                  color: colorScheme.surface,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      : ListView(
                          padding: EdgeInsets.only(top: size.height * 0.04),
                          children: [
                            Text(
                              widget.subtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: size.height * 0.03,
                                  color: colorScheme.surface,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                ),
              ),
              Positioned(
                child: Container(
                  height: size.height * 0.4,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.transparent, shape: BoxShape.rectangle),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class DesktopButton extends StatelessWidget {
  final Widget openC;
  final String title;
  final String subtitle;

  const DesktopButton(
      {Key key,
      @required this.openC,
      @required this.title,
      @required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).backgroundColor;
    return WidgetAnimator(
      OpenContainer<bool>(
        closedColor: theme,
        closedElevation: 0.0,
        openElevation: 0.0,
        openColor: theme,
        transitionType: ContainerTransitionType.fade,
        openBuilder: (context, openContainer) => openC,
        closedBuilder: (context, openContainer) =>
            SettingsLinkButton(title: title, subtitle: subtitle),
      ),
    );
  }
}
class TitleHeader extends StatelessWidget {
  final String text;

  const TitleHeader({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Column(
        children: [
          Text(text,
              style: Theme.of(context)
                  .primaryTextTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w500)),
        ],
      ),
      padding: const EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: theme.primaryColorLight,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF3A5160).withOpacity(0.2),
            offset: Offset(1.1, 1.1),
            blurRadius: 10.0,
          ),
        ],
      ),
    );
  }
}
