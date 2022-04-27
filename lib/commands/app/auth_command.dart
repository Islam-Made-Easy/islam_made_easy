// import 'package:islam_made_easy/commands/app/current_user_command.dart';
// import 'package:islam_made_easy/commands/commands.dart';
// import 'package:islam_made_easy/models/appUser.dart';
// import 'package:islam_made_easy/utils/logger.dart';
//
// class AuthenticateUserCommand extends BaseAppCommand {
//   Future<bool> run() async {
//     AppUser? user;
//     try {
//       // Authenticate user
//       user = await firebase.signAnon();
//       log("Authentication complete, user=$user");
//       // Login??
//       if (user != null) {
//         SetCurrentUserCommand().run(user);
//         return true;
//       }
//     } on Exception catch (e) {
//       log(e.toString());
//     }
//     return false;
//   }
// }
