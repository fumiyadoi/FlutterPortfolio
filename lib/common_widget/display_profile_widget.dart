import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../login_state_model.dart';
import 'display_profile_model.dart';
import 'profile_tag_widget.dart';
import 'user_img_widget.dart';

// 詳細プロフィール表示用Widget
class DisplayProfileWidget extends HookConsumerWidget {
  final String userId;

  const DisplayProfileWidget({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfileInfoState _profileInfo = ref.watch(profileInfoProvider);
    useEffect(() {
      if (userId != '') {
        final _myId = ref.watch(loginStatusProvider.state).state;
        ref.read(profileInfoProvider.notifier).updateProfileInfos(userId, _myId);
      }
      return null;
    }, []);
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // プロフ画像
            userImgWidget(_profileInfo.userId, 0, 340),
            // サブ画像用コンテナ
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                userImgWidget(_profileInfo.userId, 1, 72),
                userImgWidget(_profileInfo.userId, 2, 72),
                userImgWidget(_profileInfo.userId, 3, 72),
                userImgWidget(_profileInfo.userId, 4, 72),
              ],
            ),
            // ユーザーステータス用コンテナ
            profileContainer(
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Text(_profileInfo.status + ' ' + _profileInfo.distance + ' ' + _profileInfo.isOnline),
                  ),
                  Wrap(
                    children: [
                      const Icon(
                        Icons.comment_outlined,
                        color: Colors.grey,
                      ),
                      Text(_profileInfo.comment),
                    ],
                  ),
                ],
              ),
            ),
            // タグ用コンテナ
            profileContainer(
              _profileInfo.personalTags.isEmpty
                  ? const Text(
                      '登録されているタグがありません',
                      textAlign: TextAlign.center,
                    )
                  : Wrap(
                      children: _profileInfo.personalTags.map((personalTag) => profileTagWidget(personalTag)).toList(),
                    ),
            ),
            // 自己紹介用コンテナ
            profileContainer(
              _profileInfo.selfIntroduction == ''
                  ? const Text(
                      '自己紹介が登録されていません。',
                      textAlign: TextAlign.center,
                    )
                  : Text(_profileInfo.selfIntroduction),
            ),
            // 基本情報用コンテナ
            profileContainer(
              Column(
                children: [
                  profileInfoTitle('基本情報'),
                  profileInfoTextWidget('血液型', _profileInfo.bloodType),
                  profileInfoTextWidget('兄弟姉妹', _profileInfo.siblings),
                  profileInfoTextWidget('居住地', _profileInfo.livingPlace),
                  profileInfoTextWidget('出身地', _profileInfo.birthPlace),
                  profileInfoTextWidget('国籍', _profileInfo.country),
                  profileInfoTextWidget('話せる言語', _profileInfo.language),
                  profileInfoTextWidget('身長', _profileInfo.height),
                  profileInfoTextWidget('体型', _profileInfo.bodyShape),
                  profileInfoTextWidget('お酒', _profileInfo.alcohol),
                  profileInfoTextWidget('タバコ', _profileInfo.tobacco),
                  profileInfoTextWidget('一人暮らし/実家', _profileInfo.familyType),
                ],
              ),
            ),
            // 学歴・職業用コンテナ
            profileContainer(
              Column(
                children: [
                  profileInfoTitle('学歴・職業'),
                  profileInfoTextWidget('学歴', _profileInfo.academic),
                  profileInfoTextWidget('業種', _profileInfo.industry),
                  profileInfoTextWidget('職種・役職', _profileInfo.occupation),
                  profileInfoTextWidget('勤務地', _profileInfo.workLocation),
                  profileInfoTextWidget('年収', _profileInfo.annualIncome),
                  profileInfoTextWidget('休日', _profileInfo.holidays),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget profileContainer(Widget childWidget) {
  return Container(
    margin: const EdgeInsets.only(top: 16),
    padding: const EdgeInsets.all(16),
    width: 336,
    decoration: const BoxDecoration(color: Colors.white),
    child: childWidget,
  );
}

Widget profileInfoTitle(String title) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    width: double.infinity,
    child: Text(
      title,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 14,
      ),
    ),
  );
}

Widget profileInfoTextWidget(String title, String infoText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title),
      Text(infoText == '' ? '未設定' : infoText),
    ],
  );
}
