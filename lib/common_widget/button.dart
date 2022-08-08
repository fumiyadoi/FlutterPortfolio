import 'package:flutter/material.dart';

import 'text_bold_white.dart';

class Button extends StatelessWidget {
  final String text;
  final Color? color;
  final Function onPressed;

  const Button({
    Key? key,
    required this.text,
    this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed,
      child: TextBoldWhite(text: text),
      style: ElevatedButton.styleFrom(
        primary: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
