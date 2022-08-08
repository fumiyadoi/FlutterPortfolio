import 'package:flutter/material.dart';

class TextBold extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign? textAlign;

  const TextBold({
    Key? key,
    required this.text,
    this.fontSize = 24,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
      textAlign: textAlign,
    );
  }
}
