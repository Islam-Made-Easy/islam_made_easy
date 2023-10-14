import 'package:animated_background/animated_background.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/views/intro/fridayRem.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool isCelebration = false;
  var _today = HijriCalendar.now().wkDay;
  int _now = DateTime.now().hour;
  late final AnimationController controller;

  Future handleStartUpLogic() async {}

  getNav() {
    if ((_today == DateTime.thursday && _now > 18) ||
        (_today == DateTime.friday && _now < 18)) {
      setState(() {
        isCelebration = true;
      });
    }
    isCelebration ? Get.offAll(() => FridayRem()) : Get.offAll(() => Home());
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 200),
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        getNav();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkPrimaryColor2,
      body: Stack(
        children: [
          Center(
            child: Lottie.asset(
              'assets/lottie/progress-bar.json',
              controller: controller,
              repeat: true,
              onLoaded: (load) {
                controller.duration = load.duration + Duration(seconds: 5);
                controller.forward();
              },
            ),
          ),
          Center(
            child: Shimmer.fromColors(
              baseColor: Color(0xffFF3607),
              highlightColor: Get.theme.indicatorColor,
              child: Text(
                'ISLAM MADE EASY',
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: 'Quicksand',
                  color: Color(0xffFF3607),
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedBackground(
              vsync: this,
              behaviour: RacingLinesBehaviour(),
              child: Center(
                child: Image.asset('assets/images/red-simple.png', height: 600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
