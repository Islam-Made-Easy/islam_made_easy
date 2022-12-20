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
    with SingleTickerProviderStateMixin {
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
    !isCelebration ? Get.off(() => FridayRem()) : Get.off(() => Home());
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
        setState(() async {
          getNav();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Lottie.asset(
            'assets/lottie/loading.json',
            controller: controller,
            repeat: true,
            onLoaded: (load) {
              controller.duration = load.duration;
              controller.forward();
            },
          ),
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
