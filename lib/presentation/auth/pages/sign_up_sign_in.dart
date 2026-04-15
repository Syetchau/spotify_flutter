import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helpers/navigation_utils.dart';
import 'package:spotify/common/helpers/theme_utils.dart';
import 'package:spotify/common/widgets/app_button.dart';
import 'package:spotify/common/widgets/app_text.dart';
import 'package:spotify/common/widgets/app_top_bar.dart';
import 'package:spotify/core/configs/asset/app_images.dart';
import 'package:spotify/core/configs/asset/app_vectors.dart';
import 'package:spotify/presentation/auth/pages/sign_in.dart';
import 'package:spotify/presentation/auth/pages/sign_up.dart';

import '../../../core/configs/theme/app_colors.dart';

class SignUpSignInPage extends StatelessWidget {
  const SignUpSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppTopBar(),                                              // App bar
          _svgImage(Alignment.topRight, AppVectors.topPattern),           // Top image
          _svgImage(Alignment.bottomRight, AppVectors.bottomPattern),     // Bottom image
          _svgImage(Alignment.bottomLeft, AppImages.authBg, isSvg: false),

          // Content
          SafeArea(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppVectors.logo),      // Logo
                    const SizedBox(height: 60),             // Spacer
                    _title(context.adaptiveTextColor),      // Text
                    const SizedBox(height: 20),             // Spacer
                    _description(),                         // Text
                    const SizedBox(height: 30),             // Spacer
                    Row(
                      children: [
                        _registerBtn(() { context.push(SignUpPage()); }),  // Register button
                        const SizedBox(width: 20),                         // Spacer
                        _loginBtn(context.adaptiveTextColor, () {          // Sign in button
                          context.push(SignInPage());
                        })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _svgImage(Alignment alignment, String imagePath, { bool isSvg = true }) {
    return Align(
      alignment: alignment,
      child: isSvg
          ? SvgPicture.asset(imagePath)
          : Image.asset(imagePath)
    );
  }

  Widget _title(Color color) {
    return AppText(
      "Enjoy Listening To Music",
      fontWeight: FontWeight.bold,
      fontSize: 26,
      color: color,
    );
  }

  Widget _description() {
    return AppText(
      "Spotify is a proprietary Swedish audio streaming and media service provider",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColors.grey,
      textAlign: TextAlign.center,
    );
  }

  Widget _registerBtn(VoidCallback onPressed) {
    return Expanded(
      flex: 1,
      child: AppButton(
          onPressed: onPressed,
          title: 'Register',
          fontSize: 16
      ),
    );
  }

  Widget _loginBtn(Color color, VoidCallback onPressed) {
    return Expanded(
      flex: 1,
      child: TextButton(
          onPressed: onPressed,
          child: Text('Sign In', style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 16
          )
          )
      ),
    );
  }
}
