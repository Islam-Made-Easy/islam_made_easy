// import 'package:flutter/material.dart';
// import 'package:islam_made_easy/views/quiz/quiz_extender.dart';
// import '../home.dart';
//
// class CheckAnswersPage extends StatelessWidget {
//   final List<Question> questions;
//   final Map<int, dynamic> answers;
//
//   const CheckAnswersPage(
//       {Key? key, required this.questions, required this.answers})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     return Scaffold(
//       appBar: AppBar(title: Text('Check Answers'), elevation: 0),
//       body: Stack(
//         children: <Widget>[
//           ClipPath(
//             child: Container(
//               decoration: BoxDecoration(color: colorScheme.secondary),
//               height: 200,
//             ),
//           ),
//           ListView.builder(
//             padding: const EdgeInsets.all(16.0),
//             itemCount: questions.length + 1,
//             itemBuilder: _buildItem,
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildItem(BuildContext context, int index) {
//     if (index == questions.length) {
//       return RaisedButton(
//         child: Text("Done"),
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//         color: Theme.of(context).primaryColor,
//         textColor: Colors.white,
//         onPressed: () {
//           Navigator.of(context)
//               .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
//         },
//       );
//     }
//     Question question = questions[index];
//     bool correct = question.correctAnswer == answers[index];
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               question.question!,
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16.0),
//             ),
//             SizedBox(height: 5.0),
//             Text(
//               "${answers[index]}",
//               style: TextStyle(
//                   color: correct ? Colors.green : Colors.red,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 5.0),
//             correct
//                 ? Container()
//                 : Text.rich(
//                     TextSpan(children: [
//                       TextSpan(text: "Answer: "),
//                       TextSpan(
//                           text: question.correctAnswer,
//                           style: TextStyle(fontWeight: FontWeight.w500))
//                     ]),
//                     style: TextStyle(fontSize: 16.0),
//                   )
//           ],
//         ),
//       ),
//     );
//   }
// }
