import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'base_config.dart';

class DevConfig implements BaseConfig {
  @override
  String get base => dotenv.env['DEV_BASE_URL'] ?? " NO DEV URL";

  @override
  String get apiHost => base; // placeholder API

  @override
  String get imageHost => base + '/images';

  @override
  String get apiVersion => 'v1';

  @override
  String get firebaseAndroidApiKey =>
      dotenv.env['FIREBASE_ANDROID_API_KEY'] ?? '';
  @override
  String get firebaseAndroidAppId =>
      dotenv.env['FIREBASE_ANDROID_APP_ID'] ?? '';
  @override
  String get firebaseIosApiKey => dotenv.env['FIREBASE_IOS_API_KEY'] ?? '';
  @override
  String get firebaseIosAppId => dotenv.env['FIREBASE_IOS_APP_ID'] ?? '';
  @override
  String get firebaseIosBundleId => dotenv.env['FIREBASE_IOS_BUNDLE_ID'] ?? '';
  @override
  String get firebaseMessagingSenderId =>
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  @override
  String get firebaseProjectId => dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  @override
  String get firebaseStorageBucket =>
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';
  @override
  String get firebaseWebApiKey => dotenv.env['FIREBASE_WEB_API_KEY'] ?? '';
  @override
  String get firebaseWebAppId => dotenv.env['FIREBASE_WEB_APP_ID'] ?? '';
  @override
  String get firebaseWebAuthDomain =>
      dotenv.env['FIREBASE_WEB_AUTH_DOMAIN'] ?? '';
  @override
  String get firebaseWebMeasurementId =>
      dotenv.env['FIREBASE_WEB_MEASUREMENT_ID'] ?? '';
  @override
  String get firebaseWindowsAppId =>
      dotenv.env['FIREBASE_WINDOWS_APP_ID'] ?? '';
  @override
  String get firebaseWindowsAuthDomain =>
      dotenv.env['FIREBASE_WINDOWS_AUTH_DOMAIN'] ?? '';
  @override
  String get firebaseWindowsMeasurementId =>
      dotenv.env['FIREBASE_WINDOWS_MEASUREMENT_ID'] ?? '';
}
