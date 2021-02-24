// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class FirestoreServices {
//   FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   getQuestionData(String quizId) async {
//     return await _db.collection("quiz").doc(quizId).collection("qna").get();
//   }
//
//   getQuizData() => _db.collection("quiz").snapshots();
//
//   Future<void> addQuizData(Map quizData, String quizId) async {
//     await _db.collection("quiz").doc(quizId).set(quizData).catchError((e) {
//       print(e);
//     });
//   }
//
//   Future<void> addQuestionData(quizData, String quizId) async {
//     await _db
//         .collection("quiz")
//         .doc(quizId)
//         .collection("qna")
//         .add(quizData)
//         .catchError((e) {
//       print(e);
//     });
//   }
// }
