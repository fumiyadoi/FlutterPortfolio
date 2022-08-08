import 'package:flutter/material.dart';

// プロフィールタグのWidget
Widget profileTagWidget(String tagName) {
  return Container(
    margin: const EdgeInsets.all(4),
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(tagName),
  );
}
