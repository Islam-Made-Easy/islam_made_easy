// import 'package:flutter/material.dart';
// import 'package:islam_made_easy/models/app_model.dart';
// import 'package:islam_made_easy/services/firebase_services.dart';
// import 'package:islam_made_easy/theme/themePro.dart';
// import 'package:provider/provider.dart';
//
// BuildContext? _mainContext;
//
// BuildContext get mainContext => _mainContext!;
//
// bool get hasContext => _mainContext != null;
//
// /// Someone needs to call this so our Commands can access models and services.
// void setContext(BuildContext c) => _mainContext = c;
//
// class BaseAppCommand {
//   /// Provide quick lookups for the main Models and Services in the App.
//   T getProvided<T>() {
//     assert(_mainContext != null,
//         "You must call `setContext(BuildContext)` method before calling Commands.");
//     return _mainContext!.read<T>();
//   }
//
//   ThemeProvide get appTheme => getProvided();
//   FirebaseService get firebase => getProvided();
//   AppModel get appModel => getProvided();
// }
