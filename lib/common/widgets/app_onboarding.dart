import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/configs/asset/app_vectors.dart';
import 'app_button.dart';

class AppOnboardingPage extends StatelessWidget {
  final String backgroundImage;
  final double opacity;
  final Widget content; // <--- Dynamic content
  final String btnTitle;
  final VoidCallback onPressed;

  const AppOnboardingPage({
    super.key,
    required this.backgroundImage,
    this.opacity = 0.15,
    required this.content,
    required this.btnTitle,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(backgroundImage),
                    fit: BoxFit.fill
                )
            ),
          ),

          // Opaque
          Container(color: Colors.black.withValues(alpha: opacity)),

          // Content
          SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                child: Column(
                  children: [
                    // Logo
                    Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(AppVectors.logo)
                    ),
                    Spacer(),

                    // Dynamic content
                    content,

                    // Button
                    AppButton(onPressed: onPressed, title: btnTitle)
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
