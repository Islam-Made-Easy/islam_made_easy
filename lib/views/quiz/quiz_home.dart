import 'package:flutter/material.dart';
import 'package:islam_made_easy/theme/themePro.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';

class QuizHome extends StatefulWidget {
  const QuizHome({Key? key}) : super(key: key);

  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  @override
  void initState() {
    super.initState();
  }

  RoundedRectangleBorder kAppBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(32),
      bottomRight: Radius.circular(32),
    ),
  );

  showMessage() {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text('This section is under development'),
        backgroundColor: Theme.of(context).primaryColorLight,
        actions: [
          TextButton(
            child: Text('DISMISS'),
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
          ),
        ],
      ),
    );
  }

  static DelayUI shareDelay = DelayUI(Duration(seconds: 10));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        shape: kAppBarShape,
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
                        fontFamily: 'Roboto',
                      ),
                    ),
                    SizedBox(width: 10),
                    Hero(
                        tag: 'tag',
                        child: CircleAvatar(
                          child: FaIcon(FontAwesomeIcons.user),
                        ))
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
            Lottie.asset('assets/lottie/plant.json',
                alignment: Alignment.bottomRight),
          ],
        ),
      ),
      body: CustomScrollView(slivers: <Widget>[
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
      ]),
    );
  }

  Widget _activeTile() {
    return GestureDetector(
      onTap: () {
        shareDelay.run(() => Get.snackbar(S.current.salam, ''));
        showMessage();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColorDark),
        height: 80,
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/star.json', height: 50, repeat: false),
            Text(
              'Tawheed and Shirk',
              style: Theme.of(context).textTheme.button!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            Divider(indent: 32, endIndent: 32, color: kGreyColor)
          ],
        ),
      ),
    );
  }

  Widget _inActiveTile(tittle) {
    return MouseRegion(
      cursor: SystemMouseCursors.forbidden,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kGreyColor.withOpacity(.3)),
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).disabledColor.withOpacity(.05)),
        height: 80,
        width: 80,
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Stack(
                  children: [
                    Positioned(
                      // bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                          Theme.of(context).disabledColor.withOpacity(.5),
                          shape: BoxShape.circle,
                        ),
                        height: 50,
                        width: 30,
                      ),
                    ),
                    Positioned(
                      bottom: 18,
                      left: 10,
                      right: 10,
                      child: Container(
                          height: 15,
                          width: 7,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .highlightColor
                                  .withOpacity(.8),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(.3),
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50)),
                        height: 40,
                        width: 10,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}