import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../common_widget/recommend_users_card.dart';
import '../common_widget/text_secondary.dart';
import '../common_widget/text_bold.dart';
import 'home_model.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // トップ画像
            Container(
              height: 160,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
            ),
            // タイトル
            Container(
              margin: const EdgeInsets.only(top: 24, right: 16, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        color: Theme.of(context).primaryColor,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      const TextBold(
                        text: '本日のオファー',
                        fontSize: 22,
                      ),
                    ],
                  ),
                  const TextSecondary(
                    text: 'オファーは毎日6:00にリセットされます',
                    fontSize: 13,
                  ),
                ],
              ),
            ),
            // メンバー一覧
            FutureBuilder(
              future: addActiveUser(ref), // メンバー表示用WidgetListを生成する関数（modelで宣言）
              builder: (context, AsyncSnapshot<List<RecommendUserCard>> snapshot) {
                // 関数実行中はスピナーを表示する
                if (snapshot.connectionState == ConnectionState.none || snapshot.hasData == false) {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }
                // 関数の返り値を取得できたら、ListViewを使ってWidgetを生成する
                // ListViewについて：https://flutter.ctrnost.com/basic/layout/listview/
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    RecommendUserCard _memberInfo = snapshot.data![index];
                    return Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 16, bottom: 16, right: 28),
                          child: _memberInfo,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
