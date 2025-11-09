import 'package:flutter_riverpod/legacy.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/dump_data.dart';

import '../../../core/storage/splash_prefs.dart';

class SplashNotifier extends StateNotifier<SplashPrefs> {
  SplashNotifier() : super(SplashPrefs.instance!);

  bool get isLoggedIn => state.isLoggedIn;

  Future<void> setLoggedIn(bool value) async {
    Future.delayed(Duration(seconds: 4));

    await state.setLoggedIn(value);
    print("Logging In complete!");
  }
}

final splashProvider = StateNotifierProvider<SplashNotifier, SplashPrefs>(
  (ref) => SplashNotifier(),
);
