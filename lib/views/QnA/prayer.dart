import 'package:islam_made_easy/views/QnA/qna.dart';

class Prayer extends StatefulWidget {
  @override
  _PrayerState createState() => _PrayerState();
}

class _PrayerState extends State<Prayer> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      appBar: QnAppBar(title: S.current.swalah, isDesktop: isDesktop),
      body: Stack(
        children: [
          GradientCircles(),
          ListView(
            physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 20 : 8, vertical: isDesktop ? 22 : 8),
            children: [
              TitleHeader(text: 'Wudَu\' (Ablution)'),
              InfoCard(quest: S.current.prayerQ6, answers: [
                ViewText(data: S.current.prayerA6Par1),
                ViewText(data: S.current.prayerA6Par2),
                ViewText(data: S.current.prayerA6Par3),
                ViewText(data: S.current.prayerA6Par4),
                ViewText(data: S.current.prayerA6Par5),
                ViewText(data: S.current.prayerA6Par6),
                ViewText(data: S.current.prayerA6Par7),
                ViewText(data: " 📌${S.current.prayerA6Par8}"),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ8, answers: [
                ViewText(data: S.current.prayerA8Par1),
                ViewText(data: S.current.prayerA8Par2),
                ViewText(data: S.current.prayerA8Par3),
                ViewText(data: S.current.prayerA8Par4),
                ViewText(data: S.current.prayerA8Par5),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ10, answers: [
                ViewText(data: S.current.prayerA10Par1),
                ViewText(data: S.current.prayerA10Par2),
                ViewText(data: S.current.prayerA10Par3),
                ViewText(data: S.current.prayerA10Par4),
                ViewText(data: S.current.prayerA10Par5),
                ViewText(data: S.current.prayerA10Par6),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ11, answers: [
                ViewText(data: S.current.prayerA11Par1),
                ViewText(data: S.current.prayerA11Par2),
                ViewText(data: S.current.prayerA11Par3),
                ViewText(data: S.current.prayerA11Par4),
                ViewText(data: S.current.prayerA11Par5),
                ViewText(data: S.current.prayerA11Par6),
                ViewText(data: S.current.prayerA11Par7),
                ViewText(data: S.current.prayerA11Par8),
                ViewText(data: S.current.prayerA11Par9),
              ]),
              SizedBox(height: 10),
              TitleHeader(text: 'Adhan & Prayer Time'),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ18, answers: [
                ViewText(data: S.current.prayerA18Par1),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ14, answers: [
                ViewText(data: S.current.prayerA14Par1),
                ViewText(data: S.current.prayerA14Par2),
                ViewText(data: S.current.prayerA14Par3),
                ViewText(data: S.current.prayerA14Par4),
                ViewText(data: S.current.prayerA14Par5),
                ViewText(data: S.current.prayerA14Par6),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ19, answers: [
                ViewText(data: S.current.prayerA19Par1),
                ViewText(data: S.current.prayerA19Par2),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ20, answers: [
                ViewText(data: S.current.prayerA20Par1),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ21, answers: [
                ViewText(data: S.current.prayerA21Par1),
                ViewText(data: S.current.prayerA21Par2),
                ViewText(data: S.current.prayerA21Par3),
                ViewText(data: S.current.prayerA21Par4),
              ]),
              SizedBox(height: 10),
              TitleHeader(text: 'How to pray'),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ1, answers: [
                ViewText(data: S.current.prayerA1Par1),
                ViewText(data: S.current.prayerA1Par2),
                ViewText(data: S.current.prayerA1Par3),
                ViewText(data: S.current.prayerA1Par4),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ2, answers: [
                ViewText(data: S.current.prayerA2Par1),
                ViewText(data: S.current.prayerA2Par2),
                ViewText(data: " 📌 ${S.current.prayerA2Par3}"),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ12, answers: [
                ViewText(data: S.current.prayerA12Par1),
                ViewText(data: S.current.prayerA12Par2),
                ViewText(data: S.current.prayerA12Par3),
                ViewText(data: S.current.prayerA12Par4),
                ViewText(data: S.current.prayerA12Par5),
                ViewText(data: S.current.prayerA12Par6),
                ViewText(data: S.current.prayerA12Par7),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ22, answers: [
                ViewText(data: S.current.prayerA22Par1),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ23, answers: [
                ViewText(data: S.current.prayerA23Par1),
                ViewText(data: S.current.prayerA23Par2),
                ViewText(data: "${S.current.prayerA23Par3}"),
                ViewText(data: "${S.current.prayerA23Par4}"),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ26, answers: [
                ViewText(data: S.current.prayerA26Par1),
                ViewText(data: S.current.prayerA26Par2),
                ViewText(data: S.current.prayerA26Par3),
              ]),
              SizedBox(height: 10),
              TitleHeader(text: 'Abandoning of Prayer'),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ16, answers: [
                ViewText(data: S.current.prayerA16Par1),
                ViewText(data: S.current.prayerA16Par2),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ3, answers: [
                ViewText(data: S.current.prayerA3Par1),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ4, answers: [
                ViewText(data: S.current.prayerA4Par1),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ5, answers: [
                ViewText(data: S.current.prayerA5Par1),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ13, answers: [
                ViewText(data: S.current.prayerA13Par1),
                ViewText(data: S.current.prayerA13Par2),
                ViewText(data: S.current.prayerA13Par3),
                ViewText(data: S.current.prayerA13Par4),
                ViewText(data: S.current.prayerA13Par5),
                ViewText(data: S.current.prayerA13Par6),
              ]),
              SizedBox(height: 10),
              TitleHeader(text: 'Dua & Adhkar'),
              InfoCard(quest: S.current.prayerQ7, answers: [
                ViewText(data: S.current.prayerA7Par1),
                ViewText(data: S.current.prayerA7Par2),
                ViewText(data: S.current.prayerA7Par3),
                ViewText(data: S.current.prayerA7Par4),
                ViewText(data: " 📌 ${S.current.prayerA7Par5}"),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ17, answers: [
                ViewText(data: S.current.prayerA17Par1),
                ViewText(data: S.current.prayerA17Par2),
                ViewText(data: S.current.prayerA17Par3),
                ViewText(data: S.current.prayerA17Par4),
                ViewText(data: " 📌 ${S.current.prayerA17Par5}"),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ9, answers: [
                ViewText(data: S.current.prayerA9Par1),
                ViewText(data: S.current.prayerA9Par2),
                ViewText(data: S.current.prayerA9Par3),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ25, answers: [
                ViewText(data: S.current.prayerA25Par1),
                ViewText(data: S.current.prayerA25Par2),
                ViewText(data: S.current.prayerA25Par3),
                ViewText(data: S.current.prayerA25Par4),
                ViewText(data: S.current.prayerA25Par5),
              ]),
              SizedBox(height: 10),
              TitleHeader(text: 'Voluntary Prayer'),
              SizedBox(height: 10),
              InfoCard(quest: S.current.prayerQ15, answers: [
                ViewText(data: S.current.prayerA15Par1),
                ViewText(data: S.current.prayerA15Par2),
                ViewText(data: S.current.prayerA15Par3),
                ViewText(data: S.current.prayerA15Par4),
                ViewText(data: S.current.prayerA15Par5),
                ViewText(data: S.current.prayerA15Par6),
                ViewText(data: S.current.prayerA15Par7),
                ViewText(data: S.current.prayerA15Par8),
                ViewText(data: S.current.prayerA15Par9),
                ViewText(data: S.current.prayerA15Par10),
                ViewText(data: S.current.prayerA15Par11),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
