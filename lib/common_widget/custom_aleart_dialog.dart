import 'package:flutter/material.dart';

class CustomSimpleDialog extends StatelessWidget {
  final String title;
  final Function() onYesButtonPressed;
  final Function() onNoButtonPressed;

  const CustomSimpleDialog({
    Key? key,
    required this.title,
    required this.onYesButtonPressed,
    required this.onNoButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Column(
        children: [
          Text(
            this.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            this.title,
            style: TextStyle(fontSize: 14, color: Color(0xff646E68)),
          ),
        ],
      ),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            onYesButtonPressed();
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF16363),
              borderRadius: BorderRadius.circular(8),
            ),
            height: 48,
            child: const Text(
              'はい',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.center,
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            onNoButtonPressed();
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFECEFED),
              borderRadius: BorderRadius.circular(8),
            ),
            height: 48,
            child: const Text(
              'いいえ',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF646E68),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }
}
