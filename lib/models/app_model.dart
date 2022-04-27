// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:islam_made_easy/models/appUser.dart';
// import 'package:islam_made_easy/services/firebase_services.dart';
//
// abstract class AbstractModel extends EasyNotifier {}
//
// class AppModel extends AbstractModel {
//   AppModel(this._firebase) {}
//
//   // State
//   final Debouncer _saveDebouncer = Debouncer(const Duration(seconds: 1));
//   final FirebaseService _firebase;
//
//   void reset() => _currentUser = null;
//
//   /// Auth
//   // Current User
//   AppUser? _currentUser;
//
//   AppUser? get currentUser => _currentUser;
//
//   set currentUser(AppUser? currentUser) => notify(() => _currentUser = currentUser);
//
//   bool get isFirebaseSignedIn => _firebase.isSignedIn;
//
//   bool get hasUser => currentUser != null;
//
//   bool get isAuthenticated => hasUser && isFirebaseSignedIn;
//
//   /// Public Api
//
//   void scheduleSave() => _saveDebouncer.run(save);
//
//   Future<void> save() async {}
//
// }
//
// /// Has a notify() method that reduces boilerplate in [ChangeNotifier], similar to setState((){}) in a [StatefulWidget];
// /// Also allows external .notify() calls, being un-opinionated about whether this is called externally.
// class EasyNotifier extends ChangeNotifier {
//   void notify([VoidCallback? action]) {
//     action?.call();
//     notifyListeners();
//   }
// }
//
// class Debouncer {
//   Debouncer(this.duration);
//
//   Duration duration;
//   Timer? _timer;
//
//   void run(VoidCallback action) {
//     _timer?.cancel();
//     _timer = Timer(duration, action);
//   }
// }
