// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:islam_made_easy/models/appUser.dart';
// import 'package:islam_made_easy/services/firebase_services.dart';
//
// class NativeFirebaseService extends FirebaseService {
//   FirebaseFirestore get firestore => FirebaseFirestore.instance;
//
//   FirebaseAuth get auth => FirebaseAuth.instance;
//
//   @override
//   Future<void> init() async {
//     await Firebase.initializeApp().catchError((Object e) {
//       print("$e");
//     });
//     if (kIsWeb) {
//       await auth.setPersistence(Persistence.LOCAL);
//     }
//     print("InitComplete");
//     FirebaseAuth.instance.userChanges().listen((User? user) {
//       _isSignedIn = user != null;
//     });
//   }
//
//   // Auth
//   @override
//   Future<AppUser?> signAnon() async {
//     UserCredential userCreds;
//     userCreds = await auth.signInAnonymously();
//
//     User? user = userCreds.user;
//     return user == null ? null : AppUser(user.uid);
//   }
//
//   bool _isSignedIn = false;
//
//   @override
//   bool get isSignedIn => _isSignedIn;
//
//   @override
//   Future<List?> getPhrases() async {
//     QuerySnapshot snapshot;
//     try {
//       snapshot = await firestore.collection('phrases').get();
//       List docs = [];
//       if (snapshot.docs.isNotEmpty) {
//         for (var doc in snapshot.docs.toList()) {
//           Map a = {
//             'id':doc.id,'title':doc['title'],'subtitle':doc['subtitle'],'trailing':doc['trailing']
//           };
//           docs.add(a);
//         }
//         return docs;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Future<List?> getReference() async {
//     QuerySnapshot snapshot;
//     try {
//       snapshot = await firestore.collection('reference').get();
//       List docs = [];
//       if (snapshot.docs.isNotEmpty) {
//         for (var doc in snapshot.docs.toList()) {
//           Map a = {
//             'id':doc.id,'author':doc['author'],'about':doc['about']
//           };
//           docs.add(a);
//         }
//         return docs;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }