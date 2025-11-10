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
}
