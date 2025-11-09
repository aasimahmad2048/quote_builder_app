import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;

  final Widget child;

  const AppButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
