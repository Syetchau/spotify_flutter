import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/navigation_utils.dart';
import 'package:spotify/common/widgets/app_onboarding.dart';
import 'package:spotify/common/widgets/app_theme_button.dart';
import 'package:spotify/core/configs/asset/app_images.dart';
import 'package:spotify/core/configs/asset/app_vectors.dart';
import 'package:spotify/presentation/auth/pages/sign_up_sign_in.dart';
import 'package:spotify/presentation/choose_mode/bloc/theme_cubit.dart';
import '../../../common/widgets/app_text.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppOnboardingPage(
      backgroundImage: AppImages.chooseModeBg,
      content: Column(
        children: [
          // Text
          AppText(
            "Choose Mode",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),

          // Spacer
          const SizedBox(height: 40),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dark mode button
              AppThemeButton(
                  onPressed: () {
                    context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                    context.push(const SignUpSignInPage());
                  },
                  imagePath: AppVectors.moon,
                  text: 'Dark Mode'
              ),

              // Spacer
              const SizedBox(width: 40),

              // Light mode button
              AppThemeButton(
                  onPressed: () {
                    context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                    context.push(const SignUpSignInPage());
                  },
                  imagePath: AppVectors.sun,
                  text: 'Light Mode'
              )
            ],
          ),

          // Spacer
          const SizedBox(height: 60)
        ],
      ),
      btnTitle: 'Continue',
      onPressed: () { context.push(const SignUpSignInPage()); },
    );
  }
}
