import 'package:flutter/material.dart';

import 'text_secondary_white.dart';

class DistanceWidget extends StatelessWidget {
  final double distance;

  const DistanceWidget({
    Key? key,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String roundedDistance = distance == 0 ? 'unknown' : '${distance.toInt().toString()}km';
    return Container(
      padding: const EdgeInsets.only(top: 2, right: 8, bottom: 1, left: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: distance == 0 ? const Color(0xFFCED1D0) : Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          TextSecondaryWhite(text: roundedDistance),
        ],
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2D332F).withOpacity(0.66),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
