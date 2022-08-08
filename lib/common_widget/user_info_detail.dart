import 'package:flutter/material.dart';

import 'tag.dart';
import 'text_bold.dart';
import 'text_secondary.dart';
import 'user_image.dart';
import 'user_info_detail_model.dart';
import 'user_info_detail_row.dart';

class UserInfoDetail extends StatelessWidget {
  final String userId;

  const UserInfoDetail({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Color(0xFF00FFD1),
                Color.fromARGB(0, 136, 255, 37),
              ],
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              children: [
                UserImage(userId: userId),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: UserImage(userId: userId, index: 1),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: UserImage(userId: userId, index: 2),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: UserImage(userId: userId, index: 3),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: UserImage(userId: userId, index: 4),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        FutureBuilder(
          future: fetchUserInfo(userId),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.none || snapshot.hasData == false) {
              return Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                margin: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 24),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            TextBold(text: 'ひとことコメント', fontSize: 15, textAlign: TextAlign.start),
                            SizedBox(height: 16),
                            CircularProgressIndicator(),
                            SizedBox(height: 24),
                            TextBold(text: 'パーソナルタグ', fontSize: 15),
                            SizedBox(height: 16),
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            TextBold(text: '自己紹介', fontSize: 15),
                            SizedBox(height: 16),
                            CircularProgressIndicator(),
                            SizedBox(height: 24),
                            TextBold(text: '基本情報', fontSize: 15),
                            SizedBox(height: 16),
                            CircularProgressIndicator(),
                            SizedBox(height: 32),
                            TextBold(text: '学歴・職業', fontSize: 15),
                            SizedBox(height: 16),
                            CircularProgressIndicator(),
                            SizedBox(height: 104),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              margin: const EdgeInsets.all(0),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    TextBold(text: snapshot.data!['nickName'] != '' ? snapshot.data!['nickName'] : 'ゲスト', fontSize: 18, textAlign: TextAlign.center),
                    TextSecondary(text: snapshot.data!['age'] + '歳・' + snapshot.data!['livingPlace'], fontSize: 12, textAlign: TextAlign.center),
                    const SizedBox(height: 24),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextBold(text: 'ひとことコメント', fontSize: 15, textAlign: TextAlign.start),
                          const SizedBox(height: 16),
                          TextSecondary(text: snapshot.data!['comment']),
                          const SizedBox(height: 24),
                          const TextBold(text: 'パーソナルタグ', fontSize: 15),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            children: List<String>.from(snapshot.data!['personalTags'])
                                .map(
                                  (personalTag) => Tag(text: personalTag),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          const TextBold(text: '自己紹介', fontSize: 15),
                          const SizedBox(height: 16),
                          TextSecondary(text: snapshot.data!['introduction']),
                          const SizedBox(height: 24),
                          const TextBold(text: '基本情報', fontSize: 15),
                          const SizedBox(height: 16),
                          UserInfoDetailRow(title: '血液型', content: snapshot.data!['bloodType']),
                          UserInfoDetailRow(title: '兄弟姉妹', content: snapshot.data!['siblings']),
                          UserInfoDetailRow(title: '居住地', content: snapshot.data!['livingPlace']),
                          UserInfoDetailRow(title: '国籍', content: snapshot.data!['country']),
                          UserInfoDetailRow(title: '話せる言語', content: snapshot.data!['language']),
                          UserInfoDetailRow(title: '身長', content: snapshot.data!['height']),
                          UserInfoDetailRow(title: '体型', content: snapshot.data!['bodyShape']),
                          UserInfoDetailRow(title: 'お酒', content: snapshot.data!['alcohol']),
                          UserInfoDetailRow(title: 'タバコ', content: snapshot.data!['tobacco']),
                          UserInfoDetailRow(title: '一人暮らし / 実家', content: snapshot.data!['familyType']),
                          const SizedBox(height: 32),
                          const TextBold(text: '学歴・職業', fontSize: 15),
                          const SizedBox(height: 16),
                          UserInfoDetailRow(title: '学歴', content: snapshot.data!['academic']),
                          UserInfoDetailRow(title: '業種', content: snapshot.data!['industry']),
                          UserInfoDetailRow(title: '職種・役職', content: snapshot.data!['occupation']),
                          UserInfoDetailRow(title: '勤務地', content: snapshot.data!['workLocation']),
                          UserInfoDetailRow(title: '年収', content: snapshot.data!['annualIncome']),
                          UserInfoDetailRow(title: '休日', content: snapshot.data!['holidays']),
                          const SizedBox(height: 104),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
