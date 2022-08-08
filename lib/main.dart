import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'login_state_model.dart';

// アプリを立ち上げたときに最初に開く画面
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // ProviderScopeで囲むことで、どこでもriverpodのproviderにアクセスできる
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // テーマカラーをここで指定
        primarySwatch: colorCustom,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        // FutureBuilderを使って、遷移する画面を決める関数を実行してから表示するようにする
        // FutureBuilderの使い方：https://zenn.dev/sqer/articles/db20a4d735fb7e5928ba
        // 後で関数実行中にスピナーを表示するようにしたい
        child: FutureBuilder(
          // checkUserLoginはLoginState_model.dartに記述している
          future: checkUserLogin(ref),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // 遷移する画面が取得できたらその画面を表示する
            if (snapshot.hasData) {
              return snapshot.data;
              // 関数の実行が失敗したらエラーを表示
            } else {
              return const Text("error");
            }
          },
        ),
      ),
    );
  }
}

Map<int, Color> color = {
  50: const Color.fromRGBO(63, 227, 168, .1),
  100: const Color.fromRGBO(63, 227, 168, .2),
  200: const Color.fromRGBO(63, 227, 168, .3),
  300: const Color.fromRGBO(63, 227, 168, .4),
  400: const Color.fromRGBO(63, 227, 168, .5),
  500: const Color.fromRGBO(63, 227, 168, .6),
  600: const Color.fromRGBO(63, 227, 168, .7),
  700: const Color.fromRGBO(63, 227, 168, .8),
  800: const Color.fromRGBO(63, 227, 168, .9),
  900: const Color.fromRGBO(63, 227, 168, 1),
};

MaterialColor colorCustom = MaterialColor(0xFF3FE3A8, color);
