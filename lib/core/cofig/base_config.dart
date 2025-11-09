abstract class BaseConfig {
  String get base;
  String get apiHost;
  String get imageHost;
  String get apiVersion;

  // Firebase
  String get firebaseProjectId;
  String get firebaseMessagingSenderId;
  String get firebaseStorageBucket;

  // Android Firebase Config
  String get firebaseAndroidApiKey;
  String get firebaseAndroidAppId;

  // iOS & macOS Firebase Config
  String get firebaseIosApiKey;
  String get firebaseIosAppId;
  String get firebaseIosBundleId;

  // Web & Windows Firebase Config
  String get firebaseWebApiKey;
  String get firebaseWebAppId;
  String get firebaseWebAuthDomain;
  String get firebaseWebMeasurementId;
  String get firebaseWindowsAppId;
  String get firebaseWindowsAuthDomain;
  String get firebaseWindowsMeasurementId;
}
