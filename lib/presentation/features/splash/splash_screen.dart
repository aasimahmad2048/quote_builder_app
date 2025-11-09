import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/storage/splash_prefs.dart';
import 'splash_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    // Give the app a moment to initialize everything.
    await Future.delayed(const Duration(milliseconds: 50));
    if (mounted) {
      if (SplashPrefs.instance?.isLoggedIn == true) {
        Navigator.pushReplacementNamed(context, RouteNames.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final splashNotifierProvider = ref.read(splashProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Stack(
        children: [
          // Curved background
          ClipPath(
            clipper: CurveClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                  ],
                ),
              ),
            ),
          ),

          // Content
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'QUOTATION BUILDER',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  "Now it's easy\nto manage your business",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'The care & detail you put into invoicing can do wonders for your brand & future business.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    splashNotifierProvider.setLoggedIn(true);
                    Navigator.pushReplacementNamed(context, RouteNames.home);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'GET STARTED',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),

                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom clipper for the curve
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
