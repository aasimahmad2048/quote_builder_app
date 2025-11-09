import 'package:shared_preferences/shared_preferences.dart';

class SplashPrefs {
  SplashPrefs._(this._prefs);

  static SplashPrefs? _instance;
  final SharedPreferences _prefs;
  static const _isLoggedInKey = 'isLoggedIn';

  static Future<void> init() async {
    _instance ??= SplashPrefs._(await SharedPreferences.getInstance());
  }

  static SplashPrefs? get instance => _instance;

  bool get isLoggedIn => _prefs.getBool(_isLoggedInKey) ?? false;

  Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool(_isLoggedInKey, value);
  }
}

