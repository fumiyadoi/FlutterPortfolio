import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../send_offer/send_offer_model.dart';
import 'time_drum_model.dart';

// アクティブタイム指定用ドラムロールWidget
class TimeDrum extends ConsumerWidget {
  final String displayTime;
  final bool selectActiveTime;
  final Function saveTime;

  const TimeDrum({
    Key? key,
    required this.displayTime,
    required this.selectActiveTime,
    required this.saveTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _now = DateTime.now();
    return Container(
      height: 250,
      color: Colors.white,
      child: FutureBuilder(
        future: fetchTimeList(displayTime, selectActiveTime, ref),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.none || snapshot.hasData == false) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 閉じるボタン
                  TextButton(
                    child: const Text(
                      '閉じる',
                      style: TextStyle(
                        color: Color(0xFFF16363),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  // いつでもボタン
                  SizedBox(
                    child: selectActiveTime || !ref.watch(activeTimeProvider.state).state.isAfter(_now)
                        ? TextButton(
                            child: const Text(
                              'いつでも',
                              style: TextStyle(
                                color: Color(0xFFF16363),
                              ),
                            ),
                            onPressed: () async {
                              setAllTime(ref);
                              await saveTime(context, ref);
                            },
                          )
                        : null,
                  ),
                  // 完了ボタン
                  TextButton(
                    child: const Text(
                      '完了',
                      style: TextStyle(
                        color: Color(0xFFF16363),
                      ),
                    ),
                    onPressed: () => checkTime(saveTime, context, ref),
                  ),
                ],
              ),
              // 閉じるボタンとドラムロールの区切り線
              const Divider(),
              // CupertinoPickerはドラムロールのWidget、必ずExpandedで囲む
              Expanded(
                child: Row(
                  children: [
                    // アクティブタイム(時)
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 30,
                        children: snapshot.data!['hour'].map<Widget>((hour) => Text(hour)).toList(),
                        scrollController: FixedExtentScrollController(
                          initialItem: snapshot.data!['initHourIndex'],
                        ),
                        onSelectedItemChanged: (index) {
                          changeHour(snapshot.data!['hour']![index], ref);
                        },
                      ),
                    ),
                    // アクティブタイム(分)
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 30,
                        children: snapshot.data!['minute'].map<Widget>((minute) => Text(minute)).toList(),
                        scrollController: FixedExtentScrollController(
                          initialItem: snapshot.data!['initMinuteIndex'],
                        ),
                        onSelectedItemChanged: (index) {
                          changeMinute(snapshot.data!['minute']![index], ref);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
