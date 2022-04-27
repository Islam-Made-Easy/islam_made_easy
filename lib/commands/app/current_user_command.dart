// import 'package:islam_made_easy/commands/commands.dart';
// import 'package:islam_made_easy/models/appUser.dart';
// import 'package:islam_made_easy/utils/logger.dart';
//
// class SetCurrentUserCommand extends BaseAppCommand {
//   static bool isEmpty(String? s) => s == null || s.trim().isEmpty;
//   static bool isNotEmpty(String? s) => !isEmpty(s);
//
//   Future<void> run(AppUser? user) async {
//     log("SetCurrentUserCommand: $user");
//     // Update appController with new user. If user is null, this acts as a logout command.
//     firebase.userId = user?.uid;
//     appModel.currentUser = user;
//     if (isNotEmpty(firebase.userId)) {
//       // AppUser? user = await firebase.getUser();
//       if (user != null) {
//         appModel.currentUser = user;
//       }
//     }
//     // If currentUser is null here, then we've either logged out, or auth failed.
//     if (appModel.currentUser == null) {
//       appModel.reset();
//     }
//     appModel.save();
//   }
// }
