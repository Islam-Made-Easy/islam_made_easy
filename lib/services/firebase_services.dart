import 'package:islam_made_easy/app_keys.dart';
import 'package:islam_made_easy/models/appUser.dart';
import 'package:islam_made_easy/services/firebase_services_firedart.dart';
import 'package:islam_made_easy/services/firebase_services_native.dart';
import 'package:islam_made_easy/utils/device_info.dart';

class FireIds {
  static const String users = "users";
}

// Returns the correct Firebase instance depending on platform
class FirebaseFactory {
  static bool _initComplete = false;

  // Determine which platforms we can use the native sdk on
  static bool get useNative => DeviceOS.isMobileOrWeb;

  static FirebaseService create() {
    FirebaseService service = useNative
        ? NativeFirebaseService()
        : DartFirebaseService(
            apiKey: AppKeys.firebaseApiKey,
            projectId: AppKeys.firestoreProjectId,
          );
    if (_initComplete == false) {
      _initComplete = true;
      service.init();
    }
    print("firestore-${useNative ? "NATIVE" : "DART"} Initialized");
    return service;
  }
}

abstract class FirebaseService {
  // shared setUserId method
  String? userId;

  ///////////////////////////////////////////////////
  // Abstract Methods
  //////////////////////////////////////////////////
  void init();

  // Auth
  Future<AppUser?> signAnon();

  bool get isSignedIn;

// Stream<Map<String, dynamic>>? getDocStream(List<String> keys);
// Stream<List<Map<String, dynamic>>>? getListStream(List<String> keys);

// Future<Map<String, dynamic>?> getDoc(List<String> keys);
// Future<List<Map<String, dynamic>>?> getCollection(List<String> keys);
  Future<List?> getPhrases();
  Future<List?> getReference();
}

bool checkKeysForNull(List<String> keys) {
  if (keys.contains(null)) {
    print("ERROR: invalid key was passed to firestore: $keys");
    return false;
  }
  return true;
}
