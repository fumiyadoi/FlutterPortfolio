import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../send_offer/send_offer_model.dart';
import 'dialog_with_single_button.dart';
import 'package:intl/intl.dart';

final timeProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

Future<Map<String, dynamic>> fetchTimeList(String displayTime, bool selectActiveTime, WidgetRef ref) async {
  final _hourList = [
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '翌0',
    '翌1',
    '翌2',
    '翌3',
    '翌4',
    '翌5'
  ];
  final _minuteList = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
  ];
  final _now = DateTime.now();
  final _activeTime = ref.watch(activeTimeProvider.state).state;
  final _startTime = !selectActiveTime && _activeTime.isAfter(_now) ? _activeTime : _now;
  final _validatedHourList = _startTime.hour < 6
      ? _hourList.sublist(18 + _startTime.hour).map((hour) => hour.substring(hour.indexOf('翌') + 1)).toList()
      : _hourList.sublist(_startTime.hour - 6);
  int _initHourIndex = 0;
  int _initMinuteIndex = _minuteList.indexOf(DateFormat('mm').format(_startTime));
  if (displayTime != 'いつでも') {
    final displayHour = displayTime.substring(0, displayTime.indexOf(':'));
    final displayMinute = displayTime.substring(displayTime.indexOf(':') + 1);
    if (_validatedHourList.contains(displayHour)) {
      _initHourIndex = _validatedHourList.indexOf(displayHour);
      _initMinuteIndex = _minuteList.indexOf(displayMinute);
    }
  }
  return {
    'hour': _validatedHourList,
    'minute': _minuteList,
    'initHourIndex': _initHourIndex,
    'initMinuteIndex': _initMinuteIndex,
  };
}

changeHour(String hour, WidgetRef ref) {
  final _t = ref.watch(timeProvider.state).state;
  if (hour.contains('翌')) {
    final _hourNum = int.parse(hour.substring(1));
    ref.watch(timeProvider.state).state = DateTime(_t.year, _t.month, _t.day, _hourNum, _t.minute);
    if (_t.hour >= 6) {
      ref.watch(timeProvider.state).state = ref.watch(timeProvider.state).state.add(const Duration(days: 1));
    }
  } else {
    final _hourNum = int.parse(hour);
    ref.watch(timeProvider.state).state = DateTime(_t.year, _t.month, _t.day, _hourNum, _t.minute);
    if (_t.hour < 6 && int.parse(hour) >= 6) {
      ref.watch(timeProvider.state).state = ref.watch(timeProvider.state).state.add(const Duration(days: -1));
    }
  }
}

changeMinute(String minute, WidgetRef ref) {
  final _t = ref.watch(timeProvider.state).state;
  final _minuteNum = int.parse(minute);
  ref.watch(timeProvider.state).state = DateTime(_t.year, _t.month, _t.day, _t.hour, _minuteNum);
}

setAllTime(WidgetRef ref) {
  ref.watch(timeProvider.state).state = DateTime.now();
}

checkTime(
  Function saveTime,
  BuildContext context,
  WidgetRef ref,
) {
  if (ref.watch(timeProvider.state).state.isAfter(DateTime.now().add(const Duration(minutes: -1)))) {
    saveTime(context, ref);
  } else {
    return showDialog(
      context: context,
      builder: (context) => const DialogWithSingleButton(content: '現在時刻より前の時刻は選択できません'),
    );
  }
}
