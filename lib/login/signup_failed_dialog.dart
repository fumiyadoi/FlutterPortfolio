import 'package:flutter/material.dart';
import 'login_page.dart';

// ログインが失敗したときに表示するモーダル
Future signupFailedDialog(BuildContext context) {
  // showDialogでモーダル表示
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext content) {
      // AlertDialogでボタンつきモーダルを生成できる
      // 参考：https://webbibouroku.com/Blog/Article/flutter-dialog
      return AlertDialog(
        content: SizedBox(
          height: 128,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 横方向のcenter
            crossAxisAlignment: CrossAxisAlignment.center, // 縦方向のcenter
            children: <Widget>[
              // 「登録に失敗しました。」
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: const Text(
                  "登録に失敗しました。",
                  textAlign: TextAlign.center,
                ),
              ),
              // 「確認しました」ボタン
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  ),
                  child: const Text(
                    "確認しました",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
