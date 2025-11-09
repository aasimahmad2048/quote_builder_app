import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'base_config.dart';

class StageConfig implements BaseConfig {
  @override
  String get base => dotenv.env['STAGE_BASE_URL'] ?? "NO STATE URL";

  @override
  String get apiHost => '$base/api';

  @override
  String get imageHost => '$base/images';

  @override
  String get apiVersion => 'v1';

  @override
  // TODO: implement firebaseAndroidApiKey
  String get firebaseAndroidApiKey => throw UnimplementedError();

  @override
  // TODO: implement firebaseAndroidAppId
  String get firebaseAndroidAppId => throw UnimplementedError();

  @override
  // TODO: implement firebaseIosApiKey
  String get firebaseIosApiKey => throw UnimplementedError();

  @override
  // TODO: implement firebaseIosAppId
  String get firebaseIosAppId => throw UnimplementedError();

  @override
  // TODO: implement firebaseIosBundleId
  String get firebaseIosBundleId => throw UnimplementedError();

  @override
  // TODO: implement firebaseMessagingSenderId
  String get firebaseMessagingSenderId => throw UnimplementedError();

  @override
  // TODO: implement firebaseProjectId
  String get firebaseProjectId => throw UnimplementedError();

  @override
  // TODO: implement firebaseStorageBucket
  String get firebaseStorageBucket => throw UnimplementedError();

  @override
  // TODO: implement firebaseWebApiKey
  String get firebaseWebApiKey => throw UnimplementedError();

  @override
  // TODO: implement firebaseWebAppId
  String get firebaseWebAppId => throw UnimplementedError();

  @override
  // TODO: implement firebaseWebAuthDomain
  String get firebaseWebAuthDomain => throw UnimplementedError();

  @override
  // TODO: implement firebaseWebMeasurementId
  String get firebaseWebMeasurementId => throw UnimplementedError();

  @override
  // TODO: implement firebaseWindowsAppId
  String get firebaseWindowsAppId => throw UnimplementedError();

  @override
  // TODO: implement firebaseWindowsAuthDomain
  String get firebaseWindowsAuthDomain => throw UnimplementedError();

  @override
  // TODO: implement firebaseWindowsMeasurementId
  String get firebaseWindowsMeasurementId => throw UnimplementedError();
}
