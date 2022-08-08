import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../before_offer_member_info/before_offer_member_info_page.dart';
import 'text_bold_white.dart';
import 'user_info.dart';

// クリック可能な2人用ユーザーカードWidget
class RecommendUserCard extends ConsumerWidget {
  final String user1Id;
  final double user1Distance;
  final String user1NickName;
  final String user1Status;
  final String user2Id;
  final double user2Distance;
  final String user2NickName;
  final String user2Status;
  final String status; // コンビのオファー可能時間表示文
  final bool isActiveTime; // オファー可能時間より前か後ろか

  const RecommendUserCard({
    Key? key,
    required this.user1Id,
    required this.user1Distance,
    required this.user1NickName,
    required this.user1Status,
    required this.user2Id,
    required this.user2Distance,
    required this.user2NickName,
    required this.user2Status,
    required this.status,
    required this.isActiveTime,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      // GestureDetectorはCardWidgetをタップした時の処理を追加するために使用
      // 表示されているメンバーをタップしたら、メンバーとパートナーのidを一時保存して、オファー画面に遷移（後で修正）
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BeforeOfferMemberInfo(
              user1Id: user1Id,
              user1Distance: user1Distance,
              user1NickName: user1NickName,
              user1Status: user1Status,
              user2Id: user2Id,
              user2Distance: user2Distance,
              user2NickName: user2NickName,
              user2Status: user2Status,
              isActiveTime: isActiveTime,
            ),
          ),
        );
      },
      // 表示内容
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: UserInfo(
                      userId: user1Id,
                      distance: user1Distance,
                      status: user1Status,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: UserInfo(
                      userId: user2Id,
                      distance: user2Distance,
                      status: user2Status,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.alarm,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  TextBoldWhite(
                    text: status,
                    fontSize: 13,
                  )
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: isActiveTime ? const Color(0xFFE369C3) : const Color(0xFFEAAE66),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
