import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'users_card_root_widget.dart';
import 'users_card_model.dart';

// クリック可能な2人用ユーザーカードWidget
class UsersCardWidget extends ConsumerWidget {
  final String activeUserId; // メンバーのid
  final String activeUserStatus; // メンバーのプロフ文
  final String partnerUserId; // パートナーのid
  final String partnerUserStatus; // パートナーのプロフ文
  final String topMessage; // コンビのオファー可能時間表示文
  final List<String> offerTags; // オファータグ
  final Widget destination; // 遷移先
  final bool matched; // マッチ状態の判定用

  const UsersCardWidget({
    Key? key,
    required this.activeUserId,
    required this.activeUserStatus,
    required this.partnerUserId,
    required this.partnerUserStatus,
    required this.topMessage,
    required this.offerTags,
    required this.destination,
    required this.matched,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      // GestureDetectorはCardWidgetをタップした時の処理を追加するために使用
      // 表示されているメンバーをタップしたら、メンバーとパートナーのidを一時保存して、オファー画面に遷移（後で修正）
      onTap: () {
        ref.watch(selectedUserIdProvider.state).state = activeUserId;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      // 表示内容
      child: Card(
        color: matched ? const Color(0xFFFEFFCA) : null,
        margin: const EdgeInsets.all(16),
        // 2人用ユーザーカードWidgetを表示
        child: UsersCardRoot(
          isActiveSetUserIndex: false,
          activeUserId: activeUserId,
          activeUserStatus: activeUserStatus,
          partnerUserId: partnerUserId,
          partnerUserStatus: partnerUserStatus,
          topMessage: topMessage,
          offerTags: offerTags,
        ),
      ),
    );
  }
}
