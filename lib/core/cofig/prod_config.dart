import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get base => dotenv.env['PROD_BASE_URL'] ?? "NO PROD URL";

  @override
  String get apiHost => '$base/api';

  @override
  String get imageHost => '$base/images';





  @override
  String get apiVersion => 'v1';
 
}



