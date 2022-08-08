import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../login_state_model.dart';
import 'display_profile_model.dart';

// 現在ドラムロールで選択されているindex保管用provider
final editingDrumCurrenrIndexProvider = StateProvider((ref) {
  return 0;
});

// ドラムロールに表示するリスト取得用関数
List<String> getValueList(String property, WidgetRef ref) {
  switch (property) {
    case 'bloodType':
      return ref.watch(bloodTypeListProvider);
    case 'siblings':
      return ref.watch(siblingsListProvider);
    case 'livingPlace':
      return ref.watch(livingPlaceListProvider);
    case 'birthPlace':
      return ref.watch(birthPlaceListProvider);
    case 'country':
      return ref.watch(countryListProvider);
    case 'language':
      return ref.watch(languageListProvider);
    case 'height':
      return ref.watch(heightListProvider);
    case 'bodyShape':
      return ref.watch(bodyShapeListProvider);
    case 'alcohol':
      return ref.watch(alcoholListProvider);
    case 'tobacco':
      return ref.watch(tobaccoListProvider);
    case 'familyType':
      return ref.watch(familyTypeListProvider);
    case 'academic':
      return ref.watch(academicListProvider);
    case 'industry':
      return ref.watch(industryListProvider);
    case 'occupation':
      return ref.watch(occupationListProvider);
    case 'workLocation':
      return ref.watch(workLocationListProvider);
    case 'annualIncome':
      return ref.watch(annualIncomeListProvider);
    case 'holidays':
      return ref.watch(holidaysListProvider);
    case 'activeTime':
      List<String> _activeTimeList = ref
          .watch(activeTimeListProvider)
          .map((activeTime) => activeTime.hour == 6 ? 'いつでも' : '${activeTime.hour < 6 ? '翌 ' : ''}${activeTime.hour.toString()}:00')
          .toList();
      return _activeTimeList;
    default:
      return [];
  }
}

// 現在選択されているドラムロールの要素を取得する関数
profileInfoMethodExecuter(String property, WidgetRef ref) async {
  switch (property) {
    case 'bloodType':
      final String _value = ref.watch(bloodTypeListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeBloodType(_value);
      break;
    case 'siblings':
      final String _value = ref.watch(siblingsListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeSiblings(_value);
      break;
    case 'livingPlace':
      final String _value = ref.watch(livingPlaceListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeLivingPlace(_value);
      break;
    case 'birthPlace':
      final String _value = ref.watch(birthPlaceListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeBirthPlace(_value);
      break;
    case 'country':
      final String _value = ref.watch(countryListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeCountry(_value);
      break;
    case 'language':
      final String _value = ref.watch(languageListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeLanguage(_value);
      break;
    case 'height':
      final String _value = ref.watch(heightListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeHeight(_value);
      break;
    case 'bodyShape':
      final String _value = ref.watch(bodyShapeListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeBodyShape(_value);
      break;
    case 'alcohol':
      final String _value = ref.watch(alcoholListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeAlcohol(_value);
      break;
    case 'tobacco':
      final String _value = ref.watch(tobaccoListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeTobacco(_value);
      break;
    case 'familyType':
      final String _value = ref.watch(familyTypeListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeFamilyType(_value);
      break;
    case 'academic':
      final String _value = ref.watch(academicListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeAcademic(_value);
      break;
    case 'industry':
      final String _value = ref.watch(industryListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeIndustry(_value);
      break;
    case 'occupation':
      final String _value = ref.watch(occupationListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeOccupation(_value);
      break;
    case 'workLocation':
      final String _value = ref.watch(workLocationListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeWorkLocation(_value);
      break;
    case 'annualIncome':
      final String _value = ref.watch(annualIncomeListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeAnnualIncome(_value);
      break;
    case 'holidays':
      final String _value = ref.watch(holidaysListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      ref.watch(profileInfoProvider.notifier).changeHolidays(_value);
      break;
    case 'activeTime':
      final _uid = ref.watch(loginStatusProvider.state).state;
      final DateTime _value = ref.watch(activeTimeListProvider)[ref.watch(editingDrumCurrenrIndexProvider.state).state];
      await FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'activeTime': _value,
      });
      break;
    default:
      break;
  }
}

final bloodTypeListProvider = Provider((ref) {
  return [
    '',
    'A型',
    'B型',
    'O型',
    'AB型',
  ];
});

final siblingsListProvider = Provider((ref) {
  return [
    '',
    '一人っ子',
    '長男/長女',
    '次男/次女',
    '末っ子',
    'その他',
  ];
});

final livingPlaceListProvider = Provider((ref) {
  return [
    '',
    '北海道',
    '青森県',
    '岩手県',
    '宮城県',
    '秋田県',
    '山形県',
    '福島県',
    '茨城県',
    '栃木県',
    '群馬県',
    '埼玉県',
    '千葉県',
    '東京都',
    '神奈川県',
    '新潟県',
    '富山県',
    '石川県',
    '福井県',
    '山梨県',
    '長野県',
    '岐阜県',
    '静岡県',
    '愛知県',
    '三重県',
    '滋賀県',
    '京都府',
    '大阪府',
    '兵庫県',
    '奈良県',
    '和歌山県',
    '鳥取県',
    '島根県',
    '岡山県',
    '広島県',
    '山口県',
    '徳島県',
    '香川県',
    '愛媛県',
    '高知県',
    '福岡県',
    '佐賀県',
    '長崎県',
    '熊本県',
    '大分県',
    '宮崎県',
    '鹿児島県',
    '沖縄県'
  ];
});

final birthPlaceListProvider = Provider((ref) {
  final _birthPlaceList = ref.watch(livingPlaceListProvider);
  return _birthPlaceList;
});

final countryListProvider = Provider((ref) {
  return ['', '日本', 'その他'];
});

final languageListProvider = Provider((ref) {
  return ['', '日本語', 'その他'];
});

final heightListProvider = Provider((ref) {
  return [
    '',
    '130cm以下',
    '130cm-135cm',
    '135cm-140cm',
    '140cm-145cm',
    '145cm-150cm',
    '150cm-155cm',
    '155cm-160cm',
    '160cm-165cm',
    '165cm-170cm',
    '170cm-175cm',
    '175cm-180cm',
    '180cm-185cm',
    '185cm-190cm',
    '195cm-200cm',
    '200cm-205cm',
    '205cm-210cm',
    '210cm以上',
  ];
});

final bodyShapeListProvider = Provider((ref) {
  return [
    '',
    '細め',
    'スレンダー',
    '普通',
    'グラマー',
    'ぽっちゃり',
    'がっしり',
    'マッチョ',
    '太め',
  ];
});

final alcoholListProvider = Provider((ref) {
  return [
    '',
    'よく飲む',
    '時々飲む',
    'あまり飲まない',
    '全く飲まない',
  ];
});

final tobaccoListProvider = Provider((ref) {
  return [
    '',
    '吸わない',
    '時々吸う',
    'よく吸う',
  ];
});

final familyTypeListProvider = Provider((ref) {
  return [
    '',
    '一人暮らし',
    '実家暮らし',
    'ルームシェア',
    'その他',
  ];
});

final academicListProvider = Provider((ref) {
  return [
    '',
    '高校卒',
    '短大/専門学校卒',
    '大学卒',
    '大学院卒',
    'その他',
  ];
});

final industryListProvider = Provider((ref) {
  return [
    '',
    '流通',
    'メーカー',
    '福祉・医療',
    'IT',
    '士業',
    'その他',
  ];
});

final occupationListProvider = Provider((ref) {
  return [
    '',
    '役員',
    '管理職',
    '正社員',
    '契約社員',
    '公務員',
    '自営業',
    'その他',
  ];
});

final workLocationListProvider = Provider((ref) {
  final _workLocationList = ref.watch(livingPlaceListProvider);
  return _workLocationList;
});

final annualIncomeListProvider = Provider((ref) {
  return [
    '',
    '200万円未満',
    '200万円-400万円',
    '400万円-600万円',
    '600万円-800万円',
    '800万円-1000万円',
    '1000万円-1500万円',
    '1500万円-2000万円',
    '2000万円以上',
  ];
});

final holidaysListProvider = Provider((ref) {
  return ['', '土日祝', '不定期'];
});

final activeTimeListProvider = Provider((ref) {
  // 現在時刻を取得
  final _now = DateTime(2022, 4, 1, 15, 0); //後で変更
  if (_now.hour < 5) {
    final _prevDay = _now.subtract(const Duration(days: 1));
    final _activeTimeList =
        List.generate(6, (i) => i - 1).sublist(_now.hour + 1).map((hour) => DateTime(_now.year, _now.month, _now.day, hour, 0)).toList();
    _activeTimeList.insert(0, DateTime(_prevDay.year, _prevDay.month, _prevDay.day, 6, 0));
    return _activeTimeList;
  } else if (_now.hour >= 6) {
    final _nextDay = _now.add(const Duration(days: 1));
    final _activeTimeList = List.generate(23, (i) => i + 7)
        .sublist(_now.hour - 6)
        .map((hour) =>
            hour >= 24 ? DateTime(_nextDay.year, _nextDay.month, _nextDay.day, hour - 24, 0) : DateTime(_now.year, _now.month, _now.day, hour, 0))
        .toList();
    _activeTimeList.insert(0, DateTime(_now.year, _now.month, _now.day, 6, 0));
    return _activeTimeList;
  } else {
    return <DateTime>[];
  }
});
