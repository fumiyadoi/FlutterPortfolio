import 'package:flutter/material.dart';
import 'users_card_root_widget.dart';

// 画面上部にメンバーペアカードを表示させるWidget
PreferredSize usersAppBarWidget(
  _activeUserId,
  _activeUserStatus,
  _partnerUserId,
  _partnerUserStatus,
  _topMessage,
) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(250.0),
    child: AppBar(
      // 今回はtitleを横幅いっぱいに広げ、要素を配置している
      // 参考：https://ingrom.com/u/156546/flutter-title-to-have-max-appbar-width
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: UsersCardRoot(
        isActiveSetUserIndex: true,
        activeUserId: _activeUserId,
        activeUserStatus: _activeUserStatus,
        partnerUserId: _partnerUserId,
        partnerUserStatus: _partnerUserStatus,
        topMessage: _topMessage,
        offerTags: const [],
      ),
    ),
  );
}
