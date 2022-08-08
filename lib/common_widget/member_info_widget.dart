import 'package:flutter/material.dart';
import 'display_profile_widget.dart';
import 'users_app_bar_widget.dart';

// メンバーペア表示用Widget
Widget memberInfo(
  _activeUserId,
  _activeUserStatus,
  _partnerUserId,
  _partnerUserStatus,
  _activeTimeMessage,
  _buttonWidgetList,
) {
  return Scaffold(
    appBar: usersAppBarWidget(
      _activeUserId,
      _activeUserStatus,
      _partnerUserId,
      _partnerUserStatus,
      _activeTimeMessage,
    ),
    body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            DisplayProfileWidget(userId: _activeUserId),
            Column(
              children: _buttonWidgetList,
            ),
          ],
        ),
      ),
    ),
  );
}
