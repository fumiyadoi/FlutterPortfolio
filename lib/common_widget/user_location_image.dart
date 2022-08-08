import 'package:flutter/material.dart';
import 'distance_widget.dart';
import 'user_image.dart';

class UserLocationImage extends StatelessWidget {
  final String userId;
  final int index;
  final double distance;

  const UserLocationImage({
    Key? key,
    required this.userId,
    this.index = 0,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserImage(
      userId: userId,
      index: index,
      stack: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: DistanceWidget(distance: distance),
          ),
        ],
      ),
    );
  }
}
