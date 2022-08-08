import 'package:flutter/material.dart';

import 'text_bold.dart';
import 'text_secondary.dart';
import 'user_location_image.dart';

class UserInfo extends StatelessWidget {
  final String userId;
  final int index;
  final double distance;
  final String nickName;
  final String status;
  final String offerableTime;

  const UserInfo({
    Key? key,
    required this.userId,
    this.index = 0,
    required this.distance,
    this.nickName = '',
    this.status = '',
    this.offerableTime = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserLocationImage(
          userId: userId,
          index: index,
          distance: distance,
        ),
        const SizedBox(height: 8),
        nickName != '' ? TextBold(text: nickName, fontSize: 13) : const SizedBox(),
        status != '' ? TextSecondary(text: status, fontSize: 12) : const SizedBox(),
        offerableTime != '' ? TextSecondary(text: offerableTime, fontSize: 12) : const SizedBox(),
      ],
    );
  }
}
