import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/validator_utils.dart';

class AppEmailField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const AppEmailField({
    super.key,
    required this.controller,
    this.hintText = 'Enter Email',
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator ?? FormValidator.validateEmail,
      decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          contentPadding: const EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 16)
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
}
