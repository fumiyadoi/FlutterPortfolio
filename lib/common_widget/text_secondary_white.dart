import 'package:flutter/material.dart';

class TextSecondaryWhite extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign? textAlign;

  const TextSecondaryWhite({
    Key? key,
    required this.text,
    this.fontSize = 12,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: FontWeight.w300,
      ),
      textAlign: textAlign,
    );
  }
}
