import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../login/signup_failed_dialog.dart';
import '../login_state_model.dart';

// Googleでログインするための関数
// 後で修正予定
Future<void> signInWithGoogle(BuildContext context, WidgetRef ref) async {
  try {
    final GoogleSignIn _googleSignIn = GoogleSignIn(hostedDomain: "");
    final _googleUser = await _googleSignIn.signIn();
    // リクエストから、認証情報を取得
    final _googleAuth = await _googleUser?.authentication;
    // クレデンシャルを新しく作成
    final _credential = GoogleAuthProvider.credential(
      accessToken: _googleAuth?.accessToken,
      idToken: _googleAuth?.idToken,
    );
    final _userCredential = await FirebaseAuth.instance.signInWithCredential(_credential);
    // このタイミングでFirebaseAuth.instance.currentUserにログイン情報が反映される
    final _uid = _userCredential.user!.uid;
    ref.watch(loginStatusProvider.state).state = _uid;
    try {
      final _myDoc = await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      _myDoc['nickName'];
    } catch (e) {
      await FirebaseFirestore.instance.collection('users').doc(_uid).set({
        'activeTime': Timestamp.fromDate(DateTime(2022, 8, 1, 6, 0)),
        'favoriteUser': <String>[],
        'location': const GeoPoint(35.66425392918354, 139.69917483725288),
        'offerUserIds': <String>[],
        'livingPlace': '東京都',
        'maxAge': 50,
        'minAge': 18,
        'maxDistance': 40,
        'nickName': 'test',
        'sex': '男性'
      });
    }
  } catch (e) {
    signupFailedDialog(context);
  }
}
