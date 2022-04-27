import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/utils/load_util.dart';
import 'package:islam_made_easy/views/home.dart';
import 'package:islam_made_easy/views/intro/fridayRem.dart';
import 'package:islam_made_easy/widgets/anim/load_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with LoadingStateMixin {
  bool isCelebration = false;

  Future handleStartUpLogic() async {
    // bool success =
    //     await load(() async => await AuthenticateUserCommand().run());
    // if (success) {
    //  setState(() {getNav();});
    // }
  }

  getNav() {
    isCelebration ? Get.off(() => FridayRem()) : Get.off(() => Home());
  }

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    // handleStartUpLogic();
    return Scaffold(body: LoadingIndicator());
  }
}
