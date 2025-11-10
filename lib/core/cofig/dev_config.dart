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
}
