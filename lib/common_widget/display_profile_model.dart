import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ユーザーのプロフィール保管用クラス
@immutable
class ProfileInfoState {
  const ProfileInfoState({
    required this.userId,
    required this.status,
    required this.distance,
    required this.isOnline,
    required this.comment,
    required this.personalTags,
    required this.selfIntroduction,
    required this.bloodType,
    required this.siblings,
    required this.livingPlace,
    required this.birthPlace,
    required this.country,
    required this.language,
    required this.height,
    required this.bodyShape,
    required this.alcohol,
    required this.tobacco,
    required this.familyType,
    required this.academic,
    required this.industry,
    required this.occupation,
    required this.workLocation,
    required this.annualIncome,
    required this.holidays,
  });
  final String userId;
  final String status;
  final String distance;
  final String isOnline;
  final String comment;
  final List<String> personalTags;
  final String selfIntroduction;
  final String bloodType;
  final String siblings;
  final String livingPlace;
  final String birthPlace;
  final String country;
  final String language;
  final String height;
  final String bodyShape;
  final String alcohol;
  final String tobacco;
  final String familyType;
  final String academic;
  final String industry;
  final String occupation;
  final String workLocation;
  final String annualIncome;
  final String holidays;
}

// ユーザーのプロフィール保管用provider
class ProfileInfoController extends StateNotifier<ProfileInfoState> {
  ProfileInfoController()
      : super(const ProfileInfoState(
          userId: '',
          status: '',
          distance: '',
          isOnline: 'オフライン',
          comment: '',
          personalTags: [],
          selfIntroduction: '',
          bloodType: '',
          siblings: '',
          livingPlace: '',
          birthPlace: '',
          country: '',
          language: '',
          height: '',
          bodyShape: '',
          alcohol: '',
          tobacco: '',
          familyType: '',
          academic: '',
          industry: '',
          occupation: '',
          workLocation: '',
          annualIncome: '',
          holidays: '',
        ));

  // ユーザー情報をfirebaseから取得する関数
  void updateProfileInfos(String userId, String myId) async {
    final _userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final String _status = fetchUserStatus(_userDoc);
    final String _distance = await fetchDistance(_userDoc, userId, myId);
    String _isOnline = 'オフライン';
    try {
      _isOnline = _userDoc['presence'] ? 'オンライン' : 'オフライン';
    } catch (e) {
      debugPrint(e.toString());
    }
    final String _comment = fetchProfileInfo(_userDoc, 'comment');
    List<String> _personalTags = [];
    try {
      _personalTags = List<String>.from(_userDoc['personalTags']);
    } catch (e) {
      debugPrint(e.toString());
    }
    final String _selfIntroduction = fetchProfileInfo(_userDoc, 'selfIntroduction');
    final String _bloodType = fetchProfileInfo(_userDoc, 'bloodType');
    final String _siblings = fetchProfileInfo(_userDoc, 'siblings');
    final String _livingPlace = fetchProfileInfo(_userDoc, 'livingPlace');
    final String _birthPlace = fetchProfileInfo(_userDoc, 'birthPlace');
    final String _country = fetchProfileInfo(_userDoc, 'country');
    final String _language = fetchProfileInfo(_userDoc, 'language');
    final String _height = fetchProfileInfo(_userDoc, 'height');
    final String _bodyShape = fetchProfileInfo(_userDoc, 'bodyShape');
    final String _alcohol = fetchProfileInfo(_userDoc, 'alcohol');
    final String _tobacco = fetchProfileInfo(_userDoc, 'tobacco');
    final String _familyType = fetchProfileInfo(_userDoc, 'familyType');
    final String _academic = fetchProfileInfo(_userDoc, 'academic');
    final String _industry = fetchProfileInfo(_userDoc, 'industry');
    final String _occupation = fetchProfileInfo(_userDoc, 'occupation');
    final String _workLocation = fetchProfileInfo(_userDoc, 'workLocation');
    final String _annualIncome = fetchProfileInfo(_userDoc, 'annualIncome');
    final String _holidays = fetchProfileInfo(_userDoc, 'holidays');
    state = ProfileInfoState(
      userId: userId,
      status: _status,
      distance: _distance,
      isOnline: _isOnline,
      comment: _comment,
      personalTags: _personalTags,
      selfIntroduction: _selfIntroduction,
      bloodType: _bloodType,
      siblings: _siblings,
      livingPlace: _livingPlace,
      birthPlace: _birthPlace,
      country: _country,
      language: _language,
      height: _height,
      bodyShape: _bodyShape,
      alcohol: _alcohol,
      tobacco: _tobacco,
      familyType: _familyType,
      academic: _academic,
      industry: _industry,
      occupation: _occupation,
      workLocation: _workLocation,
      annualIncome: _annualIncome,
      holidays: _holidays,
    );
  }

  // 以下、プロフィールの値を変更したときの関数
  void switchGuest() {
    state = const ProfileInfoState(
      userId: '',
      status: 'ゲストさん',
      distance: '',
      isOnline: 'オフライン',
      comment: '',
      personalTags: [],
      selfIntroduction: '',
      bloodType: '',
      siblings: '',
      livingPlace: '',
      birthPlace: '',
      country: '',
      language: '',
      height: '',
      bodyShape: '',
      alcohol: '',
      tobacco: '',
      familyType: '',
      academic: '',
      industry: '',
      occupation: '',
      workLocation: '',
      annualIncome: '',
      holidays: '',
    );
  }

  void changeComment(String comment) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changePersonalTags(List<String> personalTags) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeSelfIntroduction(String selfIntroduction) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeBloodType(String bloodType) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeSiblings(String siblings) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeLivingPlace(String livingPlace) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeBirthPlace(String birthPlace) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeCountry(String country) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeLanguage(String language) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeHeight(String height) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeBodyShape(String bodyShape) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeAlcohol(String alcohol) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeTobacco(String tobacco) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeFamilyType(String familyType) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeAcademic(String academic) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeIndustry(String industry) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeOccupation(String occupation) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeWorkLocation(String workLocation) {
    state = ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: workLocation,
      annualIncome: state.annualIncome,
      holidays: state.holidays,
    );
  }

  void changeAnnualIncome(String annualIncome) {
    ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: annualIncome,
      holidays: state.holidays,
    );
  }

  void changeHolidays(String holidays) {
    ProfileInfoState(
      userId: state.userId,
      status: state.status,
      distance: state.distance,
      isOnline: state.isOnline,
      comment: state.comment,
      personalTags: state.personalTags,
      selfIntroduction: state.selfIntroduction,
      bloodType: state.bloodType,
      siblings: state.siblings,
      livingPlace: state.livingPlace,
      birthPlace: state.birthPlace,
      country: state.country,
      language: state.language,
      height: state.height,
      bodyShape: state.bodyShape,
      alcohol: state.alcohol,
      tobacco: state.tobacco,
      familyType: state.familyType,
      academic: state.academic,
      industry: state.industry,
      occupation: state.occupation,
      workLocation: state.workLocation,
      annualIncome: state.annualIncome,
      holidays: holidays,
    );
  }
}

final profileInfoProvider = StateNotifierProvider<ProfileInfoController, ProfileInfoState>(
  (ref) => ProfileInfoController(),
);

saveProfileInfo(WidgetRef ref) async {
  await FirebaseFirestore.instance.collection('users').doc(ref.watch(profileInfoProvider).userId).set(
    {
      'comment': ref.watch(profileInfoProvider).comment,
      'personalTags': ref.watch(profileInfoProvider).personalTags,
      'selfIntroduction': ref.watch(profileInfoProvider).selfIntroduction,
      'bloodType': ref.watch(profileInfoProvider).bloodType,
      'siblings': ref.watch(profileInfoProvider).siblings,
      'livingPlace': ref.watch(profileInfoProvider).livingPlace,
      'birthPlace': ref.watch(profileInfoProvider).birthPlace,
      'country': ref.watch(profileInfoProvider).country,
      'language': ref.watch(profileInfoProvider).language,
      'height': ref.watch(profileInfoProvider).height,
      'bodyShape': ref.watch(profileInfoProvider).bodyShape,
      'alcohol': ref.watch(profileInfoProvider).alcohol,
      'tobacco': ref.watch(profileInfoProvider).tobacco,
      'familyType': ref.watch(profileInfoProvider).familyType,
      'academic': ref.watch(profileInfoProvider).academic,
      'industry': ref.watch(profileInfoProvider).industry,
      'occupation': ref.watch(profileInfoProvider).occupation,
      'workLocation': ref.watch(profileInfoProvider).workLocation,
      'annualIncome': ref.watch(profileInfoProvider).annualIncome,
      'holidays': ref.watch(profileInfoProvider).holidays,
    },
    SetOptions(merge: true),
  );
}

String fetchUserStatus(DocumentSnapshot doc) {
  final String _nickName = doc['nickName'];
  final int _age = doc['age'];
  final String _livingPlace = doc['livingPlace'];
  final _userStatus = _nickName + 'さん(' + _age.toString() + '歳) ' + _livingPlace;
  return _userStatus;
}

fetchDistance(DocumentSnapshot userDoc, String userId, String myId) async {
  String _distanceText = '';
  if (userId != myId) {
    try {
      final _myDoc = await FirebaseFirestore.instance.collection('users').doc(myId).get();
      final GeoPoint? _myLocation = _myDoc['location'];
      try {
        final GeoPoint? _userLocation = userDoc['location'];
        if (_myLocation != null && _userLocation != null) {
          final double distanceMeter = distanceBetween(
            _myLocation.latitude,
            _myLocation.longitude,
            _userLocation.latitude,
            _userLocation.longitude,
          );
          if (distanceMeter < 499) {
            final String _distanceKiloMeter = (distanceMeter / 1000).toStringAsFixed(1);
            _distanceText = ' ' + _distanceKiloMeter + 'km先';
          } else {
            final int _distanceKiloMeter = (distanceMeter / 1000).round();
            _distanceText = ' ' + _distanceKiloMeter.toString() + 'km先';
          }
        }
      } catch (e) {
        debugPrint('user is not allowed');
      }
    } catch (e) {
      debugPrint('i am not allowed');
    }
  }
  return _distanceText;
}

double distanceBetween(
  double latitude1,
  double longitude1,
  double latitude2,
  double longitude2,
) {
  toRadians(double degree) => degree * pi / 180;
  const double r = 6378137.0; // 地球の半径
  final double f1 = toRadians(latitude1);
  final double f2 = toRadians(latitude2);
  final double l1 = toRadians(longitude1);
  final double l2 = toRadians(longitude2);
  final num a = pow(sin((f2 - f1) / 2), 2);
  final double b = cos(f1) * cos(f2) * pow(sin((l2 - l1) / 2), 2);
  final double d = 2 * r * asin(sqrt(a + b));
  return d;
}

fetchProfileInfo(DocumentSnapshot doc, String fieldName) {
  try {
    return doc[fieldName];
  } catch (e) {
    return '';
  }
}
