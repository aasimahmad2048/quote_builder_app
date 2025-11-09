import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'base_config.dart';
import 'dev_config.dart';
import 'prod_config.dart';
import 'stage_config.dart';

/// Enum representing supported environments.
enum EnvironmentType { dev, stage, prod }

/// Centralized environment manager that auto-loads config based on `.env`.
class Environment {
  /// The current configuration object (Dev, Stage, or Prod)
  static late BaseConfig config;

  /// The current environment type (dev, stage, prod)
  static late EnvironmentType type;

  /// The environment name string directly from `.env`
  static String get envName => dotenv.env['ENV']?.toLowerCase() ?? 'dev';

  /// Initialize environment config based on `.env` file.
  static void setupFromDotenv() {
    switch (envName) {
      case 'prod':
        type = EnvironmentType.prod;
        config = ProdConfig();
        break;

      case 'stage':
        type = EnvironmentType.stage;
        config = StageConfig();
        break;

      case 'dev':
      default:
        type = EnvironmentType.dev;
        config = DevConfig();
    }

    _logEnvironment();
  }

  /// Helper flags for conditional checks
  static bool get isProd => type == EnvironmentType.prod;
  static bool get isStage => type == EnvironmentType.stage;
  static bool get isDev => type == EnvironmentType.dev;

  /// Logs current environment info (only in debug mode)
  static void _logEnvironment() {
    if (kDebugMode) {
      print('====================================');
      print('🌍 Environment Loaded: ${type.name.toUpperCase()}');
      print('🔹 ENV (from .env): $envName');
      print('🔗 API Host: ${config.apiHost}');
      print('🖼️ Image Host: ${config.imageHost}');
      print('⚙️ API Version: ${config.apiVersion}');
      print('====================================');
    }
  }
}
