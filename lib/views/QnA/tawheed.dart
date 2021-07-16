import 'package:islam_made_easy/views/QnA/qna.dart';

class Tawheed extends StatefulWidget {
  @override
  _TawheedState createState() => _TawheedState();
}

// ﴾
class _TawheedState extends State<Tawheed> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      appBar: QnAppBar(title: S.current.aqeedah, isDesktop: isDesktop),
      body: Stack(
        children: [
          GradientCircles(),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            children: [
              TitleHeader(text: 'Tawheed and Shirk'),
              SizedBox(height: 5),
              InfoCard(quest: S.current.tawheedQ1, answers: [
                ViewText(data: S.current.tawheedQ1Par1),
                ViewText(data: S.current.tawheedQ1Par2),
                ViewText(data: S.current.tawheedQ1Par3),
                ViewText(data: S.current.tawheedQ1Par4),
              ]),
              SizedBox(height: 5),
              InfoCard(quest: S.current.tawheedQ3, answers: [
                ViewText(data:S.current.tawheedQ3Par1),
                ViewText(data:S.current.tawheedQ3Par2),
                ViewText(data:S.current.tawheedQ3Par3),
                ViewText(data:S.current.tawheedQ3Par4),
                ViewText(data:S.current.tawheedQ3Par5),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.tawheedQ4, answers: [
                ViewText(data: S.current.tawheedQ4U),
                SizedBox(height: 5),
                ViewText(data: S.current.tawheedQ4Par1),
                ViewText(data: S.current.tawheedQ4Par2),
                ViewText(data: S.current.tawheedQ4Par3),
                ViewText(data: S.current.tawheedQ4Par4),
              ]),
              SizedBox(height: 5),
              InfoCard(quest: S.current.tawheedQ6, answers: [
                ViewText(data: S.current.tawheedQ6Par1),
                ViewText(data: S.current.tawheedQ6Par2),
                ViewText(data: S.current.tawheedQ6Par3),
                ViewText(data: S.current.tawheedQ6Par4),
                ViewText(data: S.current.tawheedQ6Par5),
                ViewText(data: S.current.tawheedQ6Par6),
                ViewText(data: S.current.tawheedQ6Par7),
                ViewText(data: S.current.tawheedQ6Par8),
                ViewText(data: S.current.tawheedQ6Par9),
              ]),
              SizedBox(height: 5),
              InfoCard(quest: S.current.prayerQ24, answers: [
                ViewText(data: S.current.prayerA24Par1),
                ViewText(data: S.current.prayerA24Par2),
                ViewText(data: S.current.prayerA24Par3)
              ]),
              SizedBox(height: 10),
              TitleHeader(text: 'Imaan'),
              SizedBox(height: 5),
              InfoCard(quest: S.current.tawheedQ2, answers: [
                ViewText(data: S.current.tawheedQ2Par1),
                ViewText(
                    data: S.current.tawheedQ2Par2(
                        '{وَٱلسَّـٰبِقُونَ ٱلۡأَوَّلُونَ مِنَ ٱلۡمُهَـٰجِرِینَ وَٱلۡأَنصَارِ وَٱلَّذِینَ ٱتَّبَعُوهُم بِإِحۡسَـٰنࣲ}')),
                ViewText(
                    data: S.current.tawheedQ2Par3(
                        '{وَمَن یُشَاقِقِ ٱلرَّسُولَ مِنۢ بَعۡدِ مَا تَبَیَّنَ لَهُ ٱلۡهُدَىٰ وَیَتَّبِعۡ غَیۡرَ سَبِیلِ ٱلۡمُؤۡمِنِینَ}')),
                ViewText(
                    data: S.current.tawheedQ2Par4(
                        '{ٱتَّبِعُوا۟ مَن لَّا یَسۡـَٔلُكُمۡ أَجۡرࣰا وَهُم مُّهۡتَدُونَ}')),
                ViewText(
                    data: S.current.tawheedQ2Par5(
                        '{ٱتَّبِعُوا۟ مَاۤ أُنزِلَ إِلَیۡكُم مِّن رَّبِّكُمۡ وَلَا تَتَّبِعُوا۟ مِن دُونِهِۦۤ أَوۡلِیَاۤءَۗ قَلِیلࣰا مَّا تَذَكَّرُونَ}')),
              ]),
              SizedBox(height: 10),
              InfoCard(quest: S.current.tawheedQ5, answers: [
                ViewText(data: S.current.tawheedQ5Par1),
                ViewText(data: S.current.tawheedQ5Par2),
                ViewText(data: S.current.tawheedQ5Par3),
                ViewText(data: S.current.tawheedQ5Par4),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
