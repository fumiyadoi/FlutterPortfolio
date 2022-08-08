import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;

  const Tag({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FFFB),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 5),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
