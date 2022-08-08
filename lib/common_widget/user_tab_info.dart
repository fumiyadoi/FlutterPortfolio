import 'package:flutter/material.dart';

import 'distance_widget.dart';
import 'text_bold.dart';
import 'text_secondary.dart';
import 'user_image.dart';

class UserTabInfo extends StatelessWidget {
  final String userId;
  final double distance;
  final String nickName;
  final String status;

  const UserTabInfo({
    Key? key,
    required this.userId,
    required this.distance,
    this.nickName = '',
    this.status = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: UserImage(
            userId: userId,
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(bottom: 8, left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    nickName != '' ? TextBold(text: nickName, fontSize: 13) : const SizedBox(),
                    status != '' ? TextSecondary(text: status, fontSize: 12) : const SizedBox(),
                  ],
                ),
                DistanceWidget(distance: distance),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
