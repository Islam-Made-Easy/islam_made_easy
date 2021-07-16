import 'package:islam_made_easy/views/QnA/qna.dart';

class Marriage extends StatefulWidget {
  @override
  _MarriageState createState() => _MarriageState();
}

class _MarriageState extends State<Marriage> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      appBar: QnAppBar(title: S.current.nikkah, isDesktop: isDesktop),
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
              InfoCard(quest: S.current.marriageQ1, answers: [
                ViewText(data: S.current.marriageA1Par1),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.marriageQ2, answers: [
                ViewText(data: S.current.marriageA2Par1),
                ViewText(data: S.current.marriageA2Par2),
                ViewText(data: S.current.marriageA2Par3),
                ViewText(data: S.current.marriageA2Par4),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.marriageQ3, answers: [
                ViewText(data: S.current.marriageA3Par1),
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
              InfoCard(quest: S.current.marriageQ4, answers: [
                ViewText(data: S.current.marriageA4Par1),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.marriageQ6, answers: [
                ViewText(
                    data: S.current.marriageA6Par1(
                        'من أتى امرأته وهي حائض فليتصدق بدينار أو نصفه')),
                ViewText(data: S.current.marriageA6Par2),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.marriageQ5, answers: [
                ViewText(
                    data: S.current.marriageA5Par1(
                        '{لِّلَّذِینَ یُؤۡلُونَ مِن نِّسَاۤىِٕهِمۡ تَرَبُّصُ أَرۡبَعَةِ أَشۡهُرࣲۖ فَإِن فَاۤءُو فَإِنَّ ٱللَّهَ غَفُورࣱ رَّحِیمࣱ}')),
                ViewText(data: S.current.marriageA5Par2),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.marriageQ7, answers: [
                ViewText(
                    data: S.current.marriageA7Par1(
                        '{يريد الله بكم اليسر ولا يريد بكم العسر}')),
                ViewText(data: S.current.marriageA7Par2),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
