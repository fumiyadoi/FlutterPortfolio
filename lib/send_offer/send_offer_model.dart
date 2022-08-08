import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../common_widget/dialog_with_single_button.dart';
import '../common_widget/generate_id.dart';
import '../common_widget/text_field_model.dart';
import '../common_widget/time_drum_model.dart';
import '../home/home_page.dart';
import '../login_state_model.dart';

final activeTimeProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class SelectedTagsNotifier extends StateNotifier<List<String>> {
  SelectedTagsNotifier() : super([]);

  void addTag(String tag) {
    if (!state.contains(tag)) {
      state = [...state, tag];
    }
  }

  void removeTag(String tag) {
    state = [
      for (final selectedTag in state)
        if (selectedTag != tag) selectedTag,
    ];
  }

  void init() {
    state = <String>[];
  }
}

final selectedTagsProvider = StateNotifierProvider<SelectedTagsNotifier, List<String>>((ref) {
  return SelectedTagsNotifier();
});

final meetingTimeProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final displayMeetingTimeProvider = StateProvider<String>((ref) {
  final _meetingTime = ref.watch(meetingTimeProvider);
  final _now = DateTime.now();
  if (_meetingTime.isBefore(_now)) return 'いつでも';
  final _displayTime = DateFormat('H:mm').format(_meetingTime);
  if (_meetingTime.hour < 6 && _meetingTime.hour < _now.hour) return '翌' + _displayTime;
  return _displayTime;
});

final meetingPlaceProvider = StateProvider<String>((ref) {
  return '';
});

Future<List<String>> fetchTags() async {
  final _offerTagList = ['おごります', 'おごって', '中華食べたい', 'サクッと', 'ラーメン食べたい', 'ワイワイ', '来てほしい', 'いつでも行きます'];
  return _offerTagList;
}

saveMeetingTime(BuildContext context, WidgetRef ref) {
  final _time = ref.watch(timeProvider.state).state;
  final _activeTime = ref.watch(activeTimeProvider.state).state;
  if (_time.isAfter(_activeTime.add(const Duration(minutes: -1)))) {
    ref.watch(meetingTimeProvider.state).state = _time;
    Navigator.of(context).pop();
  } else {
    showDialog(
      context: context,
      builder: (context) => const DialogWithSingleButton(
        content: 'オファー受付時間より前の時間を選択できません',
      ),
    );
  }
}

saveMeetingPlace(WidgetRef ref) {
  ref.watch(meetingPlaceProvider.state).state = ref.watch(controllerProvider.state).state.text;
}

initSendOffer(WidgetRef ref) async {
  ref.read(selectedTagsProvider.notifier).init();
  final _myId = ref.watch(loginStatusProvider.state).state;
  final _myDoc = await FirebaseFirestore.instance.collection('users').doc(_myId).get();
  final DateTime _activeTime = _myDoc['activeTime'].toDate();
  final _now = DateTime.now();
  if (_activeTime.isAfter(_now)) {
    ref.watch(meetingTimeProvider.state).state = _activeTime;
    ref.watch(activeTimeProvider.state).state = _activeTime;
    ref.watch(timeProvider.state).state = _activeTime;
  } else {
    ref.watch(meetingTimeProvider.state).state = _now;
    ref.watch(activeTimeProvider.state).state = _now;
    ref.watch(timeProvider.state).state = _now;
  }
  ref.watch(meetingPlaceProvider.state).state = '';
  ref.watch(controllerProvider.state).state = TextEditingController(text: '');
}

sendOffer(String user1Id, String user2Id, BuildContext context, WidgetRef ref) async {
  final _docId = generateId();
  final _myId = ref.watch(loginStatusProvider.state).state;
  final _myDoc = await FirebaseFirestore.instance.collection('users').doc(_myId).get();
  final String _partnerId = _myDoc['partner'];
  final DateTime _meetingTime = ref.watch(meetingTimeProvider.state).state;
  final List<String> _offerTags = ref.watch(selectedTagsProvider);
  final String _meetingPlace = ref.watch(meetingPlaceProvider.state).state;
  final Timestamp _now = Timestamp.fromDate(DateTime.now());
  // 自分のfirestoreDocumentを書き換え
  await addOfferInfo(
    _docId,
    _myId,
    _partnerId,
    user1Id,
    user2Id,
    _meetingTime,
    _offerTags,
    _meetingPlace,
    _now,
    true,
  );
  // 自分のパートナーのfirestoreDocumentを書き換え
  await addOfferInfo(
    _docId,
    _partnerId,
    _myId,
    user1Id,
    user2Id,
    _meetingTime,
    _offerTags,
    _meetingPlace,
    _now,
    true,
  );
  // オファーした人1のfirestoreDocumentを書き換え
  await addOfferInfo(
    _docId,
    user1Id,
    user2Id,
    _myId,
    _partnerId,
    _meetingTime,
    _offerTags,
    _meetingPlace,
    _now,
    false,
  );
  // オファーした人2のfirestoreDocumentを書き換え
  await addOfferInfo(
    _docId,
    user2Id,
    user1Id,
    _myId,
    _partnerId,
    _meetingTime,
    _offerTags,
    _meetingPlace,
    _now,
    false,
  );
  showDialog(
    context: context,
    builder: (context) => const DialogWithSingleButton(
      content: 'オファーを送信しました！',
      onPressed: goHome,
    ),
  );
}

addOfferInfo(
  String documentId,
  String myId,
  String partnerId,
  String user1Id,
  String user2Id,
  DateTime meetingTime,
  List<String> offerTags,
  String meetingPlace,
  Timestamp now,
  bool isSender,
) async {
  final _collection = isSender ? 'offer' : 'offered';
  await FirebaseFirestore.instance.collection('users').doc(myId).update({
    // 'offerRemaining': FieldValue.increment(isSender ? -1 : 0),
    'offerUserIds': FieldValue.arrayUnion([user1Id, user2Id]),
  });
  await FirebaseFirestore.instance.collection('users').doc(myId).collection(_collection).doc(documentId).set({
    'createdAt': now,
    'matched': false,
    'meetingPlace': meetingPlace,
    'meetingTime': meetingTime,
    'offerTags': offerTags,
    'offerUserIds': FieldValue.arrayUnion([user1Id, user2Id]),
    'partner': partnerId,
  });
}

goHome(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const Home(),
    ),
  );
}
