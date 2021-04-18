import 'package:flutter/material.dart';

class GradientCircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return Stack(
      children: [
        Positioned(
          top: -115.0,
          right: ar ? -195 : 160,
          left: ar ? 140 : -195.0,
          child: Opacity(
            opacity: 0.05,
            child: new Container(
              height: 880.0,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  shape: BoxShape.circle),
            ),
          ),
        ),
        Positioned(
          top: 300,
          right: -100,
          left: 220,
          // right: ar ? -30 : 0,
          child: Opacity(
            opacity: 0.05,
            child: new Container(
              height: 110.0,
              // width: 230.0,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  shape: BoxShape.circle),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Opacity(
            opacity: 0.06,
            child: new Container(
              height: 80.0,
              width: 300.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.elliptical(80, 20)),
                  color: Theme.of(context).primaryColorDark,
                  shape: BoxShape.rectangle),
            ),
          ),
        ),
      ],
    );
  }
}

Stack circle() {
  return Stack(
    children: <Widget>[
      Container(),
      Positioned(
        top: -75.0,
        right: 85.0,
        child: Container(
          height: 120.0,
          width: 140.0,
          decoration: BoxDecoration(
              gradient: yellowOrangeGradient, shape: BoxShape.circle),
        ),
      ),
      Positioned(
        right: -7.0,
        top: 620.0,
        child: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
              gradient: yellowOrangeGradient, shape: BoxShape.circle),
        ),
      ),
      Positioned(
        right: -7.0,
        top: 245.0,
        child: Container(
          height: 150.0,
          width: 150.0,
          decoration:
              BoxDecoration(gradient: blackGradient, shape: BoxShape.circle),
        ),
      ),
      Positioned(
        left: -75.0,
        top: 775.0,
        child: Container(
          height: 150.0,
          width: 150.0,
          decoration: BoxDecoration(
              gradient: blackBlueGradient, shape: BoxShape.circle),
        ),
      ),
      Positioned(
        left: 65.0,
        top: 200.0,
        child: Container(
          height: 50.0,
          width: 50.0,
          decoration:
              BoxDecoration(gradient: skyBlueGradient, shape: BoxShape.circle),
        ),
      ),
      Positioned(
        left: 65.0,
        top: 575.0,
        child: Container(
          height: 25.0,
          width: 25.0,
          decoration:
              BoxDecoration(gradient: thodGradient, shape: BoxShape.circle),
        ),
      ),
      Positioned(
        left: 325.0,
        top: 845.0,
        child: Container(
          height: 25.0,
          width: 25.0,
          decoration:
              BoxDecoration(gradient: violetGradient, shape: BoxShape.circle),
        ),
      ),
    ],
  );
}

var blackGradient = LinearGradient(
    colors: [const Color(0xFFD626C2), const Color(0xFFA629CC)],
    tileMode: TileMode.mirror,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0]);
var violetGradient = LinearGradient(
    colors: [const Color(0xFF4884E7), const Color(0xFF7236C0)],
    tileMode: TileMode.mirror,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0]);
var thodGradient = LinearGradient(
    colors: [const Color(0xFFF58573), const Color(0xFF5F79F4)],
    tileMode: TileMode.mirror,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0]);
var skyBlueGradient = LinearGradient(
    colors: [const Color(0xFF54B6E8), const Color(0xFF39AFDC)],
    tileMode: TileMode.mirror,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0]);
var blackBlueGradient = LinearGradient(
    colors: [Colors.blueGrey.shade800, Colors.black87],
    tileMode: TileMode.mirror,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0]);
var yellowOrangeGradient = LinearGradient(
  colors: [const Color(0xFFFC944D), const Color(0xFFF53E84)],
  tileMode: TileMode.mirror,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0, 1.0],
);
