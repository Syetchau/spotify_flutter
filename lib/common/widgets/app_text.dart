import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign? textAlign;

  const AppText(
    this.text, {
    super.key,
    this.color = Colors.white, // Default Color
    this.fontWeight = FontWeight.normal, // Default Weight
    this.fontSize = 14, // Default Size
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
