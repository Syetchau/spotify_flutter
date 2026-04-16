import 'package:flutter/material.dart';
import '../helpers/validator_utils.dart';

class AppPasswordField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  AppPasswordField({
    super.key,
    required this.controller,
    this.hintText = 'Enter Password',
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isPasswordVisible,
        builder: (context, isVisible, _) {
          return TextFormField(
            controller: controller,
            obscureText: !isVisible,
            validator: validator ?? FormValidator.validatePassword,
            decoration: InputDecoration(
                hintText: hintText,
                isDense: true,
                contentPadding: const EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 16),
                suffixIcon: IconButton(
                  onPressed: () { _isPasswordVisible.value = !_isPasswordVisible.value; },
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
            ).applyDefaults(Theme.of(context).inputDecorationTheme),
          );
        }
    );
  }
}
