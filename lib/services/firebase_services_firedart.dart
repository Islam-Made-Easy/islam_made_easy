import 'dart:convert';

import 'package:firedart/auth/user_gateway.dart';
import 'package:firedart/firedart.dart';
import 'package:islam_made_easy/models/appUser.dart';
import 'package:islam_made_easy/services/firebase_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DartFirebaseService extends FirebaseService {
  DartFirebaseService({required this.apiKey, required this.projectId});

  final String apiKey;
  final String projectId;
  bool _isSignedIn = false;

  Firestore get firestore => Firestore.instance;

  FirebaseAuth get fireauth => FirebaseAuth.instance;

  @override
  Future<void> init() async {
    final prefsStore = await PreferencesStore.create();
    FirebaseAuth.initialize(apiKey, prefsStore);
    Firestore.initialize(projectId);
    _isSignedIn = fireauth.isSignedIn;
  }

  /// //////////////////////////////
  /// Auth
  Future<AppUser?> signAnon() async {
    User? user;
    try {
      user = await fireauth.signInAnonymously();
      _isSignedIn = true;
      return AppUser(user.id);
    } catch (e) {}
    return AppUser(user!.id);
  }

  @override
  bool get isSignedIn => _isSignedIn;

  /// ///////////////////////////////
  /// CRUD
  @override
  Future<List?> getPhrases() {

    throw UnimplementedError();
  }

  @override
  Future<List?> getReference() {
    // TODO: implement getReference
    throw UnimplementedError();
  }

}

class PreferencesStore extends TokenStore {
  static const keyToken = "auth_token";

  static Future<PreferencesStore> create() async =>
      PreferencesStore._internal(await SharedPreferences.getInstance());

  final SharedPreferences _prefs;

  PreferencesStore._internal(this._prefs);

  @override
  Token? read() =>
      _prefs.containsKey(keyToken)
          ? Token.fromMap(
          json.decode(_prefs.get(keyToken) as String) as Map<String, dynamic>)
          : null;

  @override
  void write(Token? token) {
    if (token == null) return;
    _prefs.setString(keyToken, json.encode(token.toMap()));
  }

  @override
  void delete() => _prefs.remove(keyToken);
}