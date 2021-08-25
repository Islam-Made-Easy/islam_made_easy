import 'package:islam_made_easy/views/QnA/qna.dart';

class Hajj extends StatefulWidget {
  @override
  _HajjState createState() => _HajjState();
}

class _HajjState extends State<Hajj> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      appBar: QnAppBar(title: S.current.hajj, isDesktop: isDesktop),
      body: Stack(
        children: [
          GradientCircles(),
          ListView(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 20 : 8,
              vertical: isDesktop ? 22 : 8,
            ),
            children: [
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ4, answers: [
                ViewText(data: S.current.prayerA4Par1),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.hajjQ1, answers: [
                ViewText(data: S.current.hajjA1par1),
                ViewText(data: S.current.hajjA1par2),
                ViewText(data: S.current.hajjA1par3),
                ViewText(data: S.current.hajjA1par4),
                ViewText(data: S.current.hajjA1par5),
                ViewText(data: S.current.hajjA1par6),
                ViewText(data: S.current.hajjA1par7),
                ViewText(data: S.current.hajjA1par8),
                ViewText(data: S.current.hajjA1par9),
                ViewText(data: S.current.hajjA1par10),
                ViewText(data: S.current.hajjA1par11),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.hajjQ2, answers: [
                ViewText(data: S.current.hajjA2par1),
                ViewText(data: S.current.hajjA2par2),
                ViewText(data: S.current.hajjA2par3),
                ViewText(data: S.current.hajjA2par4),
                ViewText(data: S.current.hajjA2par5),
                ViewText(data: S.current.hajjA2par6),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.hajjQ3, answers: [
                ViewText(data: S.current.hajjA3par1),
                ViewText(data: S.current.hajjA3par2),
                ViewText(data: S.current.hajjA3par3),
                ViewText(data: S.current.hajjA3par4),
                ViewText(data: S.current.hajjA3par5),
                ViewText(data: S.current.hajjA3par6),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.fastQ5, answers: [
                ViewText(data: S.current.fastA5par1),
                ViewText(data: S.current.fastA5par2),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
