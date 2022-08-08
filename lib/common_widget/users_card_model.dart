import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../login_state_model.dart';
import 'display_profile_model.dart';

// 選択されているメンバーペアのID保管用provider
final selectedUserIdProvider = StateProvider((ref) {
  return '';
});

// メンバーペアのID選択用関数
setUserIndex(String userId, WidgetRef ref) {
  if (ref.read(selectedUserIdProvider.state).state != userId) {
    ref.watch(selectedUserIdProvider.state).state = userId;
    if (userId != '') {
      final _myId = ref.watch(loginStatusProvider.state).state;
      ref.read(profileInfoProvider.notifier).updateProfileInfos(userId, _myId);
    } else {
      ref.read(profileInfoProvider.notifier).switchGuest();
    }
  }
}
