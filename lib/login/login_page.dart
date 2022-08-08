import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../login_state_model.dart';
import 'login_model.dart';

// riverpodを使いたいので、ConsumerWidgetクラスを継承する
class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // Columnは画面上下いっぱいに描画される
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end, // 画面の下端から子要素を並べる
        children: <Widget>[
          // グラデーション
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Color(0xFF00FFD1),
                    Color.fromARGB(0, 136, 255, 37),
                  ],
                ),
              ),
            ),
          ),
          // 「Googleで始める」ボタン
          SizedBox(
            width: 268,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                await signInWithGoogle(context, ref);
                final _route = checkUserLogin(ref);
                _route.then(
                  (value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => value),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const FaIcon(
                    FontAwesomeIcons.google,
                    size: 18,
                    color: Colors.white,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'Googleで始める',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF1877F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          // 「利用規約」「プライバシーポリシー」ボタン
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 265,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '利用規約',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'プライバシーポリシー',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
