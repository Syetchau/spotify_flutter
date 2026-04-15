import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/navigation_utils.dart';
import 'package:spotify/common/helpers/theme_utils.dart';
import 'package:spotify/presentation/auth/pages/sign_up.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_text.dart';
import '../../../common/widgets/app_top_bar.dart';
import '../../../core/configs/asset/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: SvgPicture.asset(AppVectors.logo, width: 36, height: 36)),
      bottomNavigationBar: _registerText(context),
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signInText(context.adaptiveTextColor),     // Sign In Text
            const SizedBox(height: 50),                 // Spacer
            _usernameOrEmailField(context),             // Email/Username text field
            const SizedBox(height: 20),                 // Spacer
            _passwordField(context),                    // Password
            const SizedBox(height: 20),                 // Spacer
            _signInBtn(() {                             // Sign In Button
              // TODO:
            })
          ],
        ),
      ),
    );
  }

  Widget _signInText(Color color) {
    return AppText(
      'Sign In',
      fontWeight: FontWeight.bold,
      fontSize: 24,
      textAlign: TextAlign.center,
      color: color,
    );
  }

  Widget _usernameOrEmailField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
          hintText: 'Enter Username Or Email',
          isDense: true,
          contentPadding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 16)
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
          hintText: 'Enter Password',
          isDense: true,
          contentPadding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 16)
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _registerText(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              'Not A Member?',
              fontWeight: FontWeight.w500,
              color: context.adaptiveTextColor,
            ),
            TextButton(
                onPressed: (){ context.pushReplacement(SignUpPage()); },
                child: const Text('Register Now',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)
                )
            )
          ],
        ),
      ),
    );
  }

  Widget _signInBtn(VoidCallback onPressed) {
    return AppButton(
        onPressed: onPressed,
        title: 'Sign In',
        fontSize: 16
    );
  }
}
