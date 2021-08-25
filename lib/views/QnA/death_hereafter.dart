import 'package:islam_made_easy/views/QnA/qna.dart';

class DeathHereafter extends StatefulWidget {
  @override
  _DeathHereafterState createState() => _DeathHereafterState();
}

class _DeathHereafterState extends State<DeathHereafter> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      appBar: QnAppBar(title: S.current.death, isDesktop: isDesktop),
      body: Stack(
        children: [
          GradientCircles(),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            children: [
              TitleHeader(text: 'Grave & Graveyard'),
              SizedBox(height: 5),
              InfoCard(quest: S.current.deathQ1, answers: [
                ViewText(data: S.current.deathA1Par1),
                ViewText(data: S.current.deathA1Par2),
              ]),
              SizedBox(height: 5),
              TitleHeader(text: 'Dua & Adhkar'),
              InfoCard(quest: S.current.deathQ2, answers: [
                ViewText(data: S.current.deathA2Par1),
                ViewText(data: S.current.deathA2Par2),
                ViewText(data: S.current.deathA2Par3),
              ]),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
