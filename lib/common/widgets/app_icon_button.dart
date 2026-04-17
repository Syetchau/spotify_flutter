import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class AppIconButton extends StatelessWidget {

  final String imagePath;
  final double size;
  final VoidCallback onPressed;
  final Color color;

  const AppIconButton({
    super.key,
    required this.imagePath,
    required this.onPressed,
    this.size = 60, // Default size
    this.color = AppColors.slate
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: SizedBox(
          width: 45,
          height: 45,
          child: SvgPicture.asset(imagePath, fit: BoxFit.contain)
        ),
      ),
    );
  }
}
