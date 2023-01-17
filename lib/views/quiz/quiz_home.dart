import 'package:desktop_notifications/desktop_notifications.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:provider/provider.dart';

import '../../settings/settings_pro.dart';

class QuizHome extends StatefulWidget {
  const QuizHome({Key? key}) : super(key: key);

  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> with TickerProviderStateMixin {
  late final AnimationController controller;
  bool load = false;
  late bool loaded;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 200),
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        load = true;
      }
    });
    super.initState();
  }

  RoundedRectangleBorder kAppBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(32),
      bottomRight: Radius.circular(32),
    ),
  );

  static DelayUI shareDelay = DelayUI(Duration(seconds: 10));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        shape: kAppBarShape,
        leading: IconButton(
            onPressed: () async {
              Provider.of<SettingProvide>(context, listen: false)
                  .getFullScreen(false);
              await DesktopWindow.setFullScreen(false);
              Get.back();
            },
            icon: FaIcon(Icons.chevron_left)),
        backgroundColor: Colors.transparent,
        flexibleSpace: Stack(
          children: [
            Container(
              // height: 200,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${S.current.hello} Ahmad!",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontSize: kSpacingUnit * 1.7,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2,
                          ),
                    ),
                    SizedBox(width: 10),
                    Hero(
                      tag: 'tag',
                      child: AvatarGlow(
                          endRadius: 80,
                          child: Image.asset('assets/images/light.png')),
                    )
                  ],
                ),
              ),
              // decoration: BoxDecoration(
              //   color: Theme.of(context).primaryColor.withOpacity(.5),
              //     gradient: LinearGradient(
              //       colors: [Theme.of(context).primaryColorLight,Theme.of(context).primaryColorDark],
              //       tileMode: TileMode.decal,
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //       stops: [0.0, 1.0],
              //     ),
              //     // image: DecorationImage(
              //     //     fit: BoxFit.cover,
              //     //     matchTextDirection: true,
              //     //     image: AssetImage('assets/images/deco.jpg')),
              // ),
            ),
            // Lottie.asset('assets/lottie/plant.json',
            //     alignment: Alignment.bottomRight),
          ],
        ),
      ),
      body: Stack(
        children: [
          GradientCircles(),
          CustomScrollView(slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isDesktop
                        ? 30
                        : context.isTablet
                            ? 20
                            : 16.0,
                    vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.current.playAndWin),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1.0, 4.0),
                        blurRadius: isDesktop ? 10 : 2,
                        spreadRadius: 1.0,
                      ),
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(.09),
                        offset: Offset(-4.0, -4.0),
                        blurRadius: isDesktop ? 10 : 2,
                        spreadRadius: 1.0,
                      ),
                      BoxShadow(
                        color: Colors.transparent.withOpacity(.09),
                        offset: Offset(-4.0, -4.0),
                        blurRadius: isDesktop ? 10 : 2,
                        spreadRadius: 1.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: GridView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop
                        ? 30
                        : context.isTablet
                            ? 20
                            : 16.0,
                    vertical: 30.0,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: size.height * .02,
                    childAspectRatio: 1.15,
                    crossAxisCount: isDesktop
                        ? 4
                        : context.isTablet
                            ? 3
                            : 2,
                    crossAxisSpacing: isDesktop
                        ? 30
                        : context.isTablet
                            ? 25
                            : 20,
                  ),
                  children: [
                    _activeTile(),
                    _inActiveTile('Names of Allah'),
                    _inActiveTile('Imaan'),
                    _inActiveTile('Angels'),
                    _inActiveTile('Books of Allah'),
                    _inActiveTile('Prophets & Messengers'),
                    // _inActiveTile('Others'),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _activeTile() {
    var client = NotificationsClient();
    return GestureDetector(
      onTap: () async {
        setState(() {
          loaded = true;
        });
        await client.notify(
          S.current.salam,
          body: 'This section is under development',
          appName: S.current.appTitle,
          appIcon: 'assets/images/logo.png',
        );
        await client.close();
        shareDelay.run(() =>
            Get.snackbar(S.current.salam, 'This section is under development'));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage('assets/images/sense.png'),
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.modulate,
              ),
              fit: BoxFit.fill,
              repeat: ImageRepeat.repeatY,
            ),
            border: Border.all(color: Theme.of(context).primaryColor),
            boxShadow: [
              BoxShadow(
                offset: Offset(-4.0, 4.0),
                blurRadius: 10,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(.8),
                offset: Offset(-4.0, -4.0),
                blurRadius: 10,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Colors.transparent.withOpacity(.9),
                offset: Offset(-4.0, -4.0),
                blurRadius: 10,
                spreadRadius: 1.0,
              ),
            ],
            gradient: RadialGradient(colors: [
              Color(0xffffe598).withOpacity(.5),
              Color(0xff2934BE).withOpacity(.5),
              Color(0xFF5F79F4).withOpacity(.5),
              Color(0x95AC25FF).withOpacity(.5)
            ])),
        height: 80,
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie.asset('assets/lottie/loading.json',
            //     height: 100, controller: controller),
            Text(
              'Tawheed and Shirk',
              style: Theme.of(context).textTheme.button!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Image.asset(
              'assets/images/1.png',
              color: Theme.of(context).primaryColor.withOpacity(.5),
              width: 222,
            ),
          ],
        ),
      ),
    );
  }

  Widget _inActiveTile(tittle) {
    return GestureDetector(
      onTap: () {
        setState(() {
          load = true;
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.forbidden,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage('assets/images/sense.png'),
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor.withOpacity(.5),
                BlendMode.modulate,
              ),
              fit: BoxFit.fill,
              repeat: ImageRepeat.repeatY,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  tittle,
                  style: Theme.of(context).textTheme.button!.copyWith(
                      fontSize: 20,
                      color: Theme.of(context).disabledColor,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Roboto'),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                left: 20,
                bottom: 24,
                child: load
                    ? Lottie.asset('assets/lottie/lock.json',
                        height: 50, controller: controller, onLoaded: (loaded) {
                        controller.duration = loaded.duration;
                        controller.forward();
                        load = false;
                      })
                    : Image.asset(
                        'assets/images/encry.png',
                        matchTextDirection: true,
                        height: 50,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
