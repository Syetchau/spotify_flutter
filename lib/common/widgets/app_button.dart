import 'package:flutter/material.dart';
import 'package:spotify/common/widgets/app_text.dart';

class AppButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double fontSize;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
    this.fontSize = 22
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(height ?? 60)),
        child: AppText(
          title,
          fontWeight: FontWeight.bold,
          fontSize: fontSize
        )
    );
  }
}
