import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_initializer.dart';
import 'core/routes/app_router.dart';
import 'core/routes/route_names.dart';
import 'core/storage/splash_prefs.dart';
import 'presentation/features/splash/splash_provider.dart';
import 'presentation/ui_constants/app_theme.dart';

void main() async {
  // Ensure services are initialized before the app starts.
  await AppInitializer.initialize();
  // Wrap the app in a ProviderScope for Riverpod state management.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote Builder',
      theme: AppTheme.ligthTheme,

      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: RouteNames.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}
