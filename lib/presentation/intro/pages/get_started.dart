import 'package:flutter/material.dart';
import 'package:spotify/common/widgets/app_onboarding.dart';
import 'package:spotify/common/widgets/app_text.dart';
import 'package:spotify/core/configs/asset/app_images.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/choose_mode/pages/choose_mode.dart';
import '../../../common/helpers//navigation_utils.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppOnboardingPage(
      backgroundImage: AppImages.introBg,
      content: Column(
        children: [
          // Text
          AppText(
            "Enjoy Listening To Music",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),

          // Spacer
          const SizedBox(height: 20),

          // Text
          AppText(
            "Your favorite tracks, all in one place. Experience high-quality audio like never before.",
            fontWeight: FontWeight.w500,
            color: AppColors.grey,
            textAlign: TextAlign.center,
          ),

          // Spacer
          const SizedBox(height: 20),
        ],
      ),
      btnTitle: 'Get Started',
      onPressed: () { context.push(const ChooseModePage()); },
    );
  }
}
