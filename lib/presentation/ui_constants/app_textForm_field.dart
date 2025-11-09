import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTextFormField extends ConsumerWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final Widget suffixIcon;
  final bool readOnly;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  final Function(String)? onChanged;
  final Function()? onTap;
  final int? maxLines;
  final int? minLines;
  final IconData? prefixIcon;
  final Widget? suffix;

  final FocusNode? focusNode;

  AppTextFormField({
    this.prefixIcon,
    this.suffix,

    required this.controller,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.keyboardType,

    this.suffixIcon = const SizedBox(),
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.focusNode,
    this.obscureText = false,
  });

  final bool obscureText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: Icon( prefixIcon,),
        suffix: suffix,
      ),
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      focusNode: focusNode,
      obscureText: obscureText,
    );
  }
}
