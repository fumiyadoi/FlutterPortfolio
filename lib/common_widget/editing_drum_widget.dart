import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'editing_drum_widget_model.dart';

// ドラムロールWidget
class EditingDrumWidget extends ConsumerWidget {
  final String property; // ドラムロールに表示するリストの識別子
  final String value; // 現在の設定値

  const EditingDrumWidget({
    Key? key,
    required this.property,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> _valueList = getValueList(property, ref);
    return Container(
      height: 250,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 閉じるボタン
                TextButton(
                  child: const Text('閉じる'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                // OKボタン
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () async {
                    await profileInfoMethodExecuter(property, ref);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          // 閉じるボタンとドラムロールの区切り線
          const Divider(),
          // CupertinoPickerはドラムロールのWidget、必ずExpandedで囲む
          Expanded(
            child: CupertinoPicker(
              looping: false, // ループの設定、falseでループしない
              itemExtent: 30, // itemのheightを指定
              // ドラムロールの要素を配列で指定
              children: _valueList.map((value) => Text(value == '' ? '未設定' : value)).toList(),
              // ドラムロールの初期位置を指定する
              scrollController: FixedExtentScrollController(
                // 初期位置は要素のindexで指定
                initialItem: _valueList.contains(value) ? _valueList.indexOf(value) : 0,
              ),
              // ドラムロールに変化があったときに、実行される処理
              // indexには変化後に選択されている要素のindexが入る
              onSelectedItemChanged: (index) {
                ref.watch(editingDrumCurrenrIndexProvider.state).state = index;
              },
            ),
          ),
        ],
      ),
    );
  }
}
