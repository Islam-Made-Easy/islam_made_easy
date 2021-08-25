import 'package:islam_made_easy/views/QnA/qna.dart';

class QnA extends StatefulWidget {
  static const ROUTE_NAME = "/qna";

  @override
  _QnAState createState() => _QnAState();
}

class _QnAState extends State<QnA> {
  EasyRefreshController? _controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      appBar: QnAppBar2(title: S.current!.questionsAndAnswers, isDesktop: isDesktop),
      body: Stack(
        children: [
          GradientCircles(),
          EasyRefresh(
            controller: _controller,
            child: GridView(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 30 : context.isTablet?20:16.0,
                  vertical: 30.0,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: size.height*.04,
                    crossAxisCount: isDesktop ? 4 : context.isTablet?3:2,
                    crossAxisSpacing: isDesktop ? 30 : context.isTablet?25:12),
                children:
                [
                  DesktopButton(openC: Tawheed(), title: 'assets/images/sun.jpg', subtitle: S.current!.aqeedah),
                  DesktopButton(openC: Prayer(), title: 'assets/images/msd.jpg', subtitle: S.current!.swalah),
                  DesktopButton(openC: Zakkah(), title: 'assets/images/eat.jpg', subtitle: S.current!.zakkah),
                  DesktopButton(openC: Fast(), title: 'assets/images/exq.jpg', subtitle: S.current!.swaum),
                  DesktopButton(openC: Marriage(), title: 'assets/images/marhm.jpg', subtitle: S.current!.nikkah),
                  DesktopButton(openC: Jinn(), title: 'assets/images/img1.jpg', subtitle: S.current!.jinn),
                  DesktopButton(openC: DeathHereafter(), title: 'assets/images/img2.jpg', subtitle: S.current!.death),
                  DesktopButton(openC: Lifestyle(), title: 'assets/images/rose2.jpg', subtitle: S.current!.lifestyle),
                  DesktopButton(openC: Hajj(), title: 'assets/images/ka.jpeg', subtitle: S.current!.hajj),
                ]
            ),
          ),
        ],
      ),
    );
  }
}