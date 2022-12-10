import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/utils/load_util.dart';
import 'package:islam_made_easy/views/home.dart';
import 'package:islam_made_easy/views/intro/fridayRem.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with LoadingStateMixin {
  bool isCelebration = false;

  Future handleStartUpLogic() async {}

  getNav() {
    isCelebration ? Get.off(() => FridayRem()) : Get.off(() => Home());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Shimmer.fromColors(
              baseColor: Color(0xffe2cf84),
              highlightColor: Get.theme.indicatorColor,
              child: Text(
                'ISLAM MADE EASY',
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: 'Quicksand',
                  color: Color(0xffe2cf84),
                ),
              ),
            ),
          ),
          Center(
            child: Image.asset('assets/images/up.png', height: 600),
          ),
        ],
      ),
    );
  }
}
