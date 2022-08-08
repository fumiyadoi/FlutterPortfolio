import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'text_field_model.dart';

class TextFieldWidget extends ConsumerWidget {
  final String hintText;
  final int maxLength;

  const TextFieldWidget({
    Key? key,
    this.hintText = '',
    this.maxLength = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      // controllerで入力値の変更や初期値などの設定ができる
      controller: ref.watch(controllerProvider.state).state,
      onChanged: (text) => ref.watch(textProvider.state).state = text,
      cursorColor: const Color(0xFFCED1D0),
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        // suffixiconで入力欄の右側にアイコンを表示できる
        // ここでは何か文字が入力されているとき、文字の全消去アイコンが表示されるようにする
        suffixIcon: ref.watch(textProvider.state).state != ''
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: const Color(0xFFCED1D0),
                      child: IconButton(
                        padding: const EdgeInsets.all(3),
                        iconSize: 10,
                        onPressed: () => {
                          ref.watch(controllerProvider.state).state.clear(),
                          ref.watch(textProvider.state).state = '',
                        },
                        icon: const Icon(Icons.clear, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            // 文字を入力していないときは空のWidgetを表示
            : const SizedBox(),
      ),
      maxLength: maxLength,
    );
  }
}
