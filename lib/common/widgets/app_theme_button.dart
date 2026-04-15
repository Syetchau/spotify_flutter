import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/configs/theme/app_colors.dart';
import 'app_text.dart';

class AppThemeButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String imagePath;
  final String text;

  const AppThemeButton({
    super.key,
    required this.onPressed,
    required this.imagePath,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.darkGrey2.withValues(alpha: 0.5),
                ),
                child: SvgPicture.asset(imagePath, fit: BoxFit.none),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        AppText(text, fontWeight: FontWeight.w500, fontSize: 16, color: AppColors.grey)
      ],
    );
  }
}
