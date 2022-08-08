import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common_widget/text_bold_white.dart';
import '../common_widget/text_field_widget.dart';
import 'send_offer_model.dart';

class EditMeetingPlace extends ConsumerWidget {
  const EditMeetingPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _focusNode = FocusNode();
    return Focus(
      focusNode: _focusNode,
      child: GestureDetector(
        onTap: _focusNode.requestFocus,
        child: AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          content: SizedBox(
            width: 1000,
            height: 230,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 横方向のcenter
              crossAxisAlignment: CrossAxisAlignment.center, // 縦方向のcenter
              children: <Widget>[
                const Text('希望場所を入力してください'),
                const SizedBox(height: 24),
                const SizedBox(
                  width: double.infinity,
                  child: TextFieldWidget(hintText: '希望場所'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => {
                      saveMeetingPlace(ref),
                      Navigator.of(context).pop(),
                    },
                    child: const TextBoldWhite(text: 'OK'),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
