import 'package:flutter/material.dart';

class TextBoldWhite extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign? textAlign;

  const TextBoldWhite({
    Key? key,
    required this.text,
    this.fontSize = 17,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      textAlign: textAlign,
    );
  }
}
