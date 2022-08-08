import 'package:flutter/material.dart';
import '../common_widget/floating_button.dart';
import '../common_widget/text_bold.dart';
import '../common_widget/user_info_detail.dart';
import '../common_widget/user_tab_info.dart';
import '../send_offer/send_offer_page.dart';

class BeforeOfferMemberInfo extends StatelessWidget {
  final String user1Id;
  final double user1Distance;
  final String user1NickName;
  final String user1Status;
  final String user2Id;
  final double user2Distance;
  final String user2NickName;
  final String user2Status;
  final bool isActiveTime; // オファー可能時間より前か後ろか

  const BeforeOfferMemberInfo({
    Key? key,
    required this.user1Id,
    required this.user1Distance,
    required this.user1NickName,
    required this.user1Status,
    required this.user2Id,
    required this.user2Distance,
    required this.user2NickName,
    required this.user2Status,
    required this.isActiveTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          // タイトル
          centerTitle: true,
          title: const TextBold(
            text: 'オファー詳細',
            fontSize: 18,
          ),
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            child: TabBar(
              tabs: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: Tab(
                    child: UserTabInfo(
                      userId: user1Id,
                      distance: user1Distance,
                      nickName: user1NickName,
                      status: user1Status,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: Tab(
                    child: UserTabInfo(
                      userId: user2Id,
                      distance: user2Distance,
                      nickName: user2NickName,
                      status: user2Status,
                    ),
                  ),
                ),
              ],
            ),
            preferredSize: Size(double.infinity, MediaQuery.of(context).size.width * 0.2),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: UserInfoDetail(
                userId: user1Id,
              ),
            ),
            SingleChildScrollView(
              child: UserInfoDetail(
                userId: user2Id,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FloatingButton(
                iconData: Icons.favorite,
                text: 'Like',
                color: const Color(0xFFE369C3),
                onPressed: () {},
              ),
              const SizedBox(width: 24),
              FloatingButton(
                iconData: Icons.send,
                text: 'オファー',
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SendOffer(user1Id: user1Id, user2Id: user2Id)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
