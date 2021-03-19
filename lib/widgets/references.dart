import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';
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
  AnimationController _animationController3;
  Animation<double> _curvedAnimation3;
  AnimationController _animationController4;
  Animation<double> _curvedAnimation4;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _curvedAnimation1 =
        CurvedAnimation(parent: _animationController1, curve: Curves.easeInOut);
    _animationController3 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _curvedAnimation3 =
        CurvedAnimation(parent: _animationController3, curve: Curves.easeInOut);
    _animationController4 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _curvedAnimation4 =
        CurvedAnimation(parent: _animationController4, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController1.dispose();
    _animationController3.dispose();
    _animationController4.dispose();
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

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: isDesktop ? theme.backgroundColor : Color(0xffEEF1FA),
      appBar: AppBar(
        title: Text(S.current.references),
        centerTitle: true,
        elevation: 0,
        backgroundColor:
            isDesktop ? Colors.transparent : theme.appBarTheme.color,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 10 : 0, vertical: isDesktop ? 50 : 0),
        children: [
          Container(
            decoration: isDesktop
                ? BoxDecoration(
                    color: Color(0xFFFAFAFC).withOpacity(0.2),
                    border: Border.all(color: theme.backgroundColor),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      matchTextDirection: true,
                      image: AssetImage('assets/images/frame1.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        theme.backgroundColor.withOpacity(0.4),
                        BlendMode.colorBurn,
                      ),
                    ),
                  )
                : BoxDecoration(color: theme.backgroundColor),
            padding: EdgeInsets.all(isDesktop ? 42 : 10),
            child: Column(
              children: [
                FlipView(
                  animationController: _curvedAnimation1,
                  front: _buildCardF(
                      S.current.tawheedBookAuthor, () => _flip1(true), ''),
                  back: _buildCardB(
                      () => _flip1(false), S.current.tawheedAboutAuthor),
                ),
                FlipView(
                  animationController: _curvedAnimation,
                  front: _buildCardF(
                      S.current.prerequisiteAuthor, () => _flip(true), ''),
                  back: _buildCardB(
                      () => _flip(false), S.current.prerequisiteAboutAuthor),
                ),
                FlipView(
                  animationController: _curvedAnimation3,
                  front:
                      _buildCardF(S.current.qnaAnswer1, () => _flip3(true), ''),
                  back: _buildCardB(() => _flip3(false), S.current.aboutAlwan),
                ),
                FlipView(
                  animationController: _curvedAnimation4,
                  front:
                      _buildCardF(S.current.hajjAuthor, () => _flip4(true), ''),
                  back: _buildCardB(() => _flip4(false), S.current.aboutJibril),
                ),
                FlipView(
                  animationController: _curvedAnimation4,
                  front: _buildCardF(
                      S.current.fatawaAuthor2, () => _flip4(true), ''),
                  back: _buildCardB(
                      () => _flip4(false), S.current.aboutFatawaAuthor2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardF(String title, GestureTapCallback onTap, String about) {
    return Card(
      elevation: 4,
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
    return Card(
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
