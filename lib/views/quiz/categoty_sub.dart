import 'package:islam_made_easy/views/QnA/qna.dart';

class QuizSub extends StatefulWidget {
  final String categorySub;

  const QuizSub({Key key, this.categorySub}) : super(key: key);

  @override
  _QuizSubState createState() => _QuizSubState();
}

class _QuizSubState extends State<QuizSub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: [
          Text("Hello User!"),
          Text("Play and win to unlock more categories"),
          Card(child: ListTile(title: Text(widget.categorySub),))
        ],
      ),
    );
  }
}
