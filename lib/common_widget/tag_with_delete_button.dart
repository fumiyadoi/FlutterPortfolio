import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagWithDeleteButton extends ConsumerWidget {
  final String text;
  final Function onPressed;

  const TagWithDeleteButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FFFB),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 4),
          CircleAvatar(
            radius: 7,
            backgroundColor: const Color(0xFFCED1D0),
            child: IconButton(
              padding: const EdgeInsets.all(2),
              iconSize: 10,
              onPressed: () => onPressed(text),
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
