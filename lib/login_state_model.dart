import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home/home_page.dart';
import 'login/login_page.dart';

// ログインしているユーザーのuserIDを保存するためのStateProvider
final loginStatusProvider = StateProvider((ref) {
  return FirebaseAuth.instance.currentUser?.uid ?? '';
});

// 登録状況に応じ、遷移する画面を決める関数
Future checkUserLogin(WidgetRef ref) async {
  // ログインしてなければ、ログイン画面へ
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    return const Login();
  }
  // 上記以外はホーム画面へ
  return const Home();
}
