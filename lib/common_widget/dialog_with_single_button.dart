import 'package:flutter/material.dart';

import 'text_bold_white.dart';

class DialogWithSingleButton extends StatelessWidget {
  final String content;
  final String buttonText;
  final Function? onPressed;

  const DialogWithSingleButton({
    Key? key,
    required this.content,
    this.buttonText = 'OK',
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      content: SizedBox(
        width: 1000,
        height: 116,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 横方向のcenter
          crossAxisAlignment: CrossAxisAlignment.center, // 縦方向のcenter
          children: <Widget>[
            Text(content),
            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () => onPressed == null ? Navigator.of(context).pop() : onPressed!(context),
                child: const TextBoldWhite(text: 'OK'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
