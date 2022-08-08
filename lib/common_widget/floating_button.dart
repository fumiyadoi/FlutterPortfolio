import 'package:flutter/material.dart';

import 'text_secondary_white.dart';

class FloatingButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color color;
  final void Function() onPressed;

  const FloatingButton({
    Key? key,
    required this.iconData,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: FloatingActionButton(
        heroTag: text,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 32,
            ),
            TextSecondaryWhite(text: text),
          ],
        ),
        backgroundColor: color,
        onPressed: onPressed,
      ),
    );
  }
}
