import 'package:flutter/material.dart';

import 'text_secondary.dart';

class UserInfoDetailRowCanEdit extends StatelessWidget {
  final String title;
  final String content;

  const UserInfoDetailRowCanEdit({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE3E5E5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextSecondary(text: title, fontSize: 13),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content == '' ? '未設定' : content,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF2D332F),
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFFCED1D0))
            ],
          )
        ],
      ),
    );
  }
}
