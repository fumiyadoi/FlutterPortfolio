import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_tag_widget.dart';
import 'users_card_model.dart';
import 'user_img_widget.dart';

// 2人用ユーザーカードWidget
class UsersCardRoot extends StatelessWidget {
  final bool isActiveSetUserIndex; // メンバーの選択をできるようにするか
  final String activeUserId; // メンバーのid
  final String activeUserStatus; // メンバーのプロフ文
  final String partnerUserId; // パートナーのid
  final String partnerUserStatus; // パートナーのプロフ文
  final String topMessage; // コンビのオファー可能時間表示文
  final List<String> offerTags; // オファータグ

  const UsersCardRoot({
    Key? key,
    required this.isActiveSetUserIndex,
    required this.activeUserId,
    required this.activeUserStatus,
    required this.partnerUserId,
    required this.partnerUserStatus,
    required this.topMessage,
    required this.offerTags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        // オファー時間を表示する
        // いつでもオファー可能なら何も表示しない
        topMessage == ''
            ? const SizedBox()
            : Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(topMessage),
              ),
        // メンバーとパートナーの情報を横並びで表示
        Row(
          children: [
            Expanded(
              flex: 1, // ここでwidthの割合を設定
              // メンバーの情報を表示
              child: UserSummeryWidget(
                isActiveSetUserIndex: isActiveSetUserIndex,
                userId: activeUserId,
                userStatus: activeUserStatus,
              ),
            ),
            Expanded(
              flex: 1, // ここでwidthの割合を設定
              // メンバーの情報を表示
              child: UserSummeryWidget(
                isActiveSetUserIndex: isActiveSetUserIndex,
                userId: partnerUserId,
                userStatus: partnerUserStatus,
              ),
            ),
          ],
        ),
        // タグを横並びで表示
        Wrap(
          children: offerTags.map((String tagName) => profileTagWidget(tagName)).toList(),
        ),
      ],
    );
  }
}

class UserSummeryWidget extends ConsumerWidget {
  final bool isActiveSetUserIndex; // メンバーの選択をできるようにするか
  final String userId; // メンバーのid
  final String userStatus; // メンバーのプロフ文

  const UserSummeryWidget({
    Key? key,
    required this.isActiveSetUserIndex,
    required this.userId,
    required this.userStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isActiveSetUserIndex) {
      return GestureDetector(
        onTap: () {
          setUserIndex(userId, ref);
        },
        child: userSummeryWidgetRoot(userId, userStatus),
      );
    }
    return userSummeryWidgetRoot(userId, userStatus);
  }
}

Widget userSummeryWidgetRoot(String userId, String userStatus) {
  return Container(
    margin: const EdgeInsets.all(16),
    child: Center(
      child: Column(
        children: [
          // プロフ画像
          userImgWidget(userId, 0, 130),
          // プロフ文
          Text(userStatus),
        ],
      ),
    ),
  );
}
