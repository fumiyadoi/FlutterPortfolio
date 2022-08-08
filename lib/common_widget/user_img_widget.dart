import 'package:flutter/material.dart';
import 'user_img_widget_model.dart';

// プロフ画像表示用Widget
Widget userImgWidget(String userId, int index, double size) {
  return FutureBuilder(
    future: fetchUserImg(userId, index),
    builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
      if (snapshot.connectionState == ConnectionState.none || snapshot.hasData == false) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          height: size,
          width: size,
          // プロフ画像のURLがなければ灰色画像を表示
          child: const Center(child: CircularProgressIndicator()),
        );
      }
      return snapshot.data!['imageUrl'] == ''
          ? Container(
              margin: const EdgeInsets.all(8),
              height: size,
              width: size,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: size * 0.5,
                  ),
                  Text(
                    'No Image',
                    style: TextStyle(
                      fontSize: size * 0.15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFCED1D0),
                borderRadius: BorderRadius.circular(10),
              ),
            )
          : Container(
              margin: const EdgeInsets.all(8),
              height: size,
              width: size,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(snapshot.data!['imageUrl']!),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            );
    },
  );
}
