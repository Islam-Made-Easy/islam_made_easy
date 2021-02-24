// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:islam_made_easy/models/appUser.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   AppUser _user(User user) {
//     return user != null ? AppUser(user.uid) : null;
//   }
//
//   Future getInAnon() async {
//     try {
//       var authResult = await _auth.signInAnonymously();
//       User user = authResult.user;
//       return _user(user);
//     } catch (e) {
//       return e.message;
//     }
//   }
// }
