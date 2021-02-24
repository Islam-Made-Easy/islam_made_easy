// import 'package:flutter/material.dart';
// import 'package:islam_made_easy/views/quiz/quiz_extender.dart';
//
// class QuizSTile extends StatefulWidget {
//   final QModel questionModel;
//   final int index;
//
//   QuizSTile({@required this.questionModel, @required this.index});
//
//   @override
//   _QuizSTileState createState() => _QuizSTileState();
// }
//
// class _QuizSTileState extends State<QuizSTile> {
//   String optionSelected = "";
//   int _correct = 0;
//   int _incorrect = 0;
//   int _notAttempted = 0;
//   int total = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               "Q${widget.index + 1} ${widget.questionModel.question}",
//               style:
//                   TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
//             ),
//           ),
//           SizedBox(height: 12),
//           GestureDetector(
//             onTap: () {
//               if (!widget.questionModel.answered) {
//                 ///correct
//                 if (widget.questionModel.option1 ==
//                     widget.questionModel.correctOption) {
//                   setState(() {
//                     optionSelected = widget.questionModel.option1;
//                     widget.questionModel.answered = true;
//                     _correct = _correct + 1;
//                     _notAttempted = _notAttempted + 1;
//                   });
//                 } else {
//                   setState(() {
//                     optionSelected = widget.questionModel.option1;
//                     widget.questionModel.answered = true;
//                     _incorrect = _incorrect + 1;
//                     _notAttempted = _notAttempted - 1;
//                   });
//                 }
//               }
//             },
//             child: OptionTile(
//               option: "A",
//               description: "${widget.questionModel.option1}",
//               correctAnswer: widget.questionModel.correctOption,
//               optionSelected: optionSelected,
//             ),
//           ),
//           SizedBox(height: 4),
//           GestureDetector(
//             onTap: () {
//               if (!widget.questionModel.answered) {
//                 ///correct
//                 if (widget.questionModel.option2 ==
//                     widget.questionModel.correctOption) {
//                   setState(() {
//                     optionSelected = widget.questionModel.option2;
//                     widget.questionModel.answered = true;
//                     _correct = _correct + 1;
//                     _notAttempted = _notAttempted + 1;
//                   });
//                 } else {
//                   setState(() {
//                     optionSelected = widget.questionModel.option2;
//                     widget.questionModel.answered = true;
//                     _incorrect = _incorrect + 1;
//                     _notAttempted = _notAttempted - 1;
//                   });
//                 }
//               }
//             },
//             child: OptionTile(
//               option: "B",
//               description: "${widget.questionModel.option2}",
//               correctAnswer: widget.questionModel.correctOption,
//               optionSelected: optionSelected,
//             ),
//           ),
//           SizedBox(height: 4),
//           GestureDetector(
//             onTap: () {
//               if (!widget.questionModel.answered) {
//                 ///correct
//                 if (widget.questionModel.option3 ==
//                     widget.questionModel.correctOption) {
//                   setState(() {
//                     optionSelected = widget.questionModel.option3;
//                     widget.questionModel.answered = true;
//                     _correct = _correct + 1;
//                     _notAttempted = _notAttempted + 1;
//                   });
//                 } else {
//                   setState(() {
//                     optionSelected = widget.questionModel.option3;
//                     widget.questionModel.answered = true;
//                     _incorrect = _incorrect + 1;
//                     _notAttempted = _notAttempted - 1;
//                   });
//                 }
//               }
//             },
//             child: OptionTile(
//               option: "C",
//               description: "${widget.questionModel.option3}",
//               correctAnswer: widget.questionModel.correctOption,
//               optionSelected: optionSelected,
//             ),
//           ),
//           SizedBox(height: 4),
//           GestureDetector(
//             onTap: () {
//               if (!widget.questionModel.answered) {
//                 ///correct
//                 if (widget.questionModel.option4 ==
//                     widget.questionModel.correctOption) {
//                   setState(() {
//                     optionSelected = widget.questionModel.option4;
//                     widget.questionModel.answered = true;
//                     _correct = _correct + 1;
//                     _notAttempted = _notAttempted + 1;
//                   });
//                 } else {
//                   setState(() {
//                     optionSelected = widget.questionModel.option4;
//                     widget.questionModel.answered = true;
//                     _incorrect = _incorrect + 1;
//                     _notAttempted = _notAttempted - 1;
//                   });
//                 }
//               }
//             },
//             child: OptionTile(
//               option: "D",
//               description: "${widget.questionModel.option4}",
//               correctAnswer: widget.questionModel.correctOption,
//               optionSelected: optionSelected,
//             ),
//           ),
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }
