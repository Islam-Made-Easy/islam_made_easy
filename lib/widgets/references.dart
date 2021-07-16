import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';

class References extends StatefulWidget {
  @override
  _ReferencesState createState() => _ReferencesState();
}

class _ReferencesState extends State<References> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _curvedAnimation;
  AnimationController _animationController1;
  Animation<double> _curvedAnimation1;
  AnimationController _animationController2;
  Animation<double> _curvedAnimation2;
  AnimationController _animationController5;
  Animation<double> _curvedAnimation5;
  AnimationController _animationController3;
  Animation<double> _curvedAnimation3;
  AnimationController _animationController4;
  Animation<double> _curvedAnimation4;
  var time = Duration(milliseconds: 1000);
  var anim = Curves.easeInOut;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: time);
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: anim);
    _animationController1 = AnimationController(vsync: this, duration: time);
    _curvedAnimation1 =
        CurvedAnimation(parent: _animationController1, curve: anim);
    _animationController2 = AnimationController(vsync: this, duration: time);
    _curvedAnimation2 =
        CurvedAnimation(parent: _animationController2, curve: anim);
    _animationController3 = AnimationController(vsync: this, duration: time);
    _curvedAnimation3 =
        CurvedAnimation(parent: _animationController3, curve: anim);
    _animationController4 = AnimationController(vsync: this, duration: time);
    _curvedAnimation4 =
        CurvedAnimation(parent: _animationController4, curve: anim);
    _animationController5 = AnimationController(vsync: this, duration: time);
    _curvedAnimation5 =
        CurvedAnimation(parent: _animationController5, curve: anim);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController1.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
    _animationController4.dispose();
    _animationController5.dispose();
    super.dispose();
  }

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _flip1(bool reverse) {
    if (_animationController1.isAnimating) return;
    if (reverse) {
      _animationController1.forward();
    } else {
      _animationController1.reverse();
    }
  }

  void _flip2(bool reverse) {
    if (_animationController2.isAnimating) return;
    if (reverse) {
      _animationController2.forward();
    } else {
      _animationController2.reverse();
    }
  }

  void _flip3(bool reverse) {
    if (_animationController3.isAnimating) return;
    if (reverse) {
      _animationController3.forward();
    } else {
      _animationController3.reverse();
    }
  }

  void _flip4(bool reverse) {
    if (_animationController4.isAnimating) return;
    if (reverse) {
      _animationController4.forward();
    } else {
      _animationController4.reverse();
    }
  }

  void _flip5(bool reverse) {
    if (_animationController5.isAnimating) return;
    if (reverse) {
      _animationController5.forward();
    } else {
      _animationController5.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.references),
        centerTitle: true,
        backgroundColor: isDesktop ? Colors.transparent : null,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 10 : 0, vertical: isDesktop ? 50 : 0),
        children: [
          Container(
            decoration: isDesktop
                ? BoxDecoration(
                    color: theme.cardColor.withOpacity(.2),
                    border: Border.all(color: theme.hoverColor),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      matchTextDirection: true,
                      image: AssetImage('assets/images/frame1.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        theme.hintColor.withOpacity(.4),
                        BlendMode.dst,
                      ),
                    ),
                  )
                : BoxDecoration(),
            padding: EdgeInsets.all(isDesktop ? 42 : 10),
            child: Column(
              children: [
                FlipView(
                  animationController: _curvedAnimation1,
                  front: _buildCardF(
                      S.current.tawheedBookAuthor, () => _flip1(true)),
                  back: _buildCardB(
                      () => _flip1(false), S.current.tawheedAboutAuthor),
                ),
                FlipView(
                  animationController: _curvedAnimation,
                  front: _buildCardF(
                      S.current.prerequisiteAuthor, () => _flip(true)),
                  back: _buildCardB(
                      () => _flip(false), S.current.prerequisiteAboutAuthor),
                ),
                FlipView(
                  animationController: _curvedAnimation3,
                  front: _buildCardF(S.current.qnaAnswer1, () => _flip3(true)),
                  back: _buildCardB(() => _flip3(false), S.current.aboutAlwan),
                ),
                FlipView(
                  animationController: _curvedAnimation4,
                  front: _buildCardF(S.current.hajjAuthor, () => _flip4(true)),
                  back: _buildCardB(() => _flip4(false), S.current.aboutJibril),
                ),
                FlipView(
                  animationController: _curvedAnimation2,
                  front:
                      _buildCardF(S.current.fatawaAuthor2, () => _flip2(true)),
                  back: _buildCardB(
                      () => _flip2(false), S.current.aboutFatawaAuthor2),
                ),
                FlipView(
                  animationController: _curvedAnimation5,
                  front: _buildCardF(
                      S.current.tawheedIntroAuthor, () => _flip5(true)),
                  back: _buildCardB(
                      () => _flip5(false), 'He is a student of knowledge, studied vocabulary, nahw (grammar) and sarf (morphology). Mainly translates '
                      'books of ‘aqīdah of the Salaf.\n${S.current.tawheedIntroTitle}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardF(String title, GestureTapCallback onTap) {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return Card(
      shape: GetPlatform.isWeb
          ? null
          : RoundedRectangleBorder(
              side: BorderSide(width: .5, color: Theme.of(context).hoverColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ar ? 0 : 10),
                topRight: Radius.circular(ar ? 10 : 0),
                bottomRight:
                    ar ? Radius.elliptical(90, 10) : Radius.elliptical(90, 10),
                bottomLeft: ar
                    ? Radius.elliptical(12, 200)
                    : Radius.elliptical(12, 200),
              ),
            ),
      elevation: GetPlatform.isWeb?10:30,
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(
          title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildCardB(GestureTapCallback onTap, String about) {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return Card(
      shape: GetPlatform.isWeb
          ? null
          : RoundedRectangleBorder(
        side: BorderSide(width: .5, color: Theme.of(context).hoverColor),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ar ? 0 : 10),
          topRight: Radius.circular(ar ? 10 : 0),
          bottomLeft:
              ar ? Radius.elliptical(90, 10) : Radius.elliptical(12, 200),
          bottomRight:
              ar ? Radius.elliptical(12, 200) : Radius.elliptical(90, 10),
        ),
      ),
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(
          S.current.about,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          about,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        onTap: onTap,
      ),
    );
  }
}
