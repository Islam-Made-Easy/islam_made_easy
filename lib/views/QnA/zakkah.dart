import 'package:islam_made_easy/views/QnA/qna.dart';

class Zakkah extends StatefulWidget {
  @override
  _ZakkahState createState() => _ZakkahState();
}

class _ZakkahState extends State<Zakkah> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      appBar: QnAppBar(title: S.current.zakkah, isDesktop: isDesktop),
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
              InfoCard(quest: S.current.charityQ2, answers: [
                 ViewText(data:S.current.charityA2Par1(
                    '{إِنَّمَا ٱلصَّدَقَـٰتُ لِلۡفُقَرَاۤءِ وَٱلۡمَسَـٰكِینِ وَٱلۡعَـٰمِلِینَ عَلَیۡهَا وَٱلۡمُؤَلَّفَةِ قُلُوبُهُمۡ وَفِی ٱلرِّقَابِ وَٱلۡغَـٰرِمِینَ وَفِی سَبِیلِ ٱللَّهِ وَٱبۡنِ ٱلسَّبِیلِۖ فَرِیضَةࣰ مِّنَ ٱللَّهِۗ وَٱللَّهُ عَلِیمٌ حَكِیمࣱ}')),
                 ViewText(data:S.current.charityA2Par2),
                 ViewText(data:S.current.charityA2Par3),
                 ViewText(data:S.current.charityA2Par4),
                 ViewText(data:S.current.charityA2Par5),
                 ViewText(data:S.current.charityA2Par6),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.charityQ1, answers: [
                 ViewText(data:S.current.charityA1Par1),
                 ViewText(data:S.current.charityA1Par2),
                 ViewText(data:S.current.charityA1Par3),
                 ViewText(data:S.current.charityA1Par4),
                 ViewText(data:S.current.charityA1Par5),
                 ViewText(data:S.current.charityA1Par6),
                 ViewText(data:S.current.charityA1Par7),
                 ViewText(data:S.current.charityA1Par8),
                 ViewText(data:S.current.charityA1Par9),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.charityQ3, answers: [
                 ViewText(data:S.current.charityA3Par1),
                 ViewText(data:S.current.charityA3Par2),
                 ViewText(data:S.current.charityA3Par3),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
