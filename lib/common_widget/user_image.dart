import 'package:flutter/material.dart';
import 'user_img_widget_model.dart';

class UserImage extends StatelessWidget {
  final String userId;
  final int index;
  final Widget stack;

  const UserImage({
    Key? key,
    required this.userId,
    this.index = 0,
    this.stack = const SizedBox(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchUserImg(userId, index),
      builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.none || snapshot.hasData == false) {
          return Container(
            width: double.infinity,
            // プロフ画像のURLがなければ灰色画像を表示
            child: const AspectRatio(
              aspectRatio: 1,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFCED1D0),
              borderRadius: BorderRadius.circular(10),
            ),
          );
        }
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: snapshot.data!['imageUrl'] == ''
                  ? const AssetImage('assets/noImage-profile@3x.jpg') as ImageProvider
                  : NetworkImage(snapshot.data!['imageUrl']!),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: stack,
          ),
        );
      },
    );
  }
}
