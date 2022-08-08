import 'package:flutter/material.dart';

// ボタンWidget
Widget buttonWidget(
  String buttonText, // ボタンに表示する文字
  Color? buttonColor, // ボタンの背景色
  void Function() onButtonPressed, // ボタンを押した時の処理
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    width: 336,
    height: 48,
    child: ElevatedButton(
      onPressed: onButtonPressed,
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}
