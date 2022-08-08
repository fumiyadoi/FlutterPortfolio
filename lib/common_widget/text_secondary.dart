import 'package:flutter/material.dart';

class TextSecondary extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign? textAlign;

  const TextSecondary({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: const Color(0xFF646E68),
        fontWeight: FontWeight.w300,
      ),
      textAlign: textAlign,
    );
  }
}
