import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import '../common_widget/display_profile_model.dart';
import '../common_widget/recommend_users_card.dart';
import '../login_state_model.dart';

Future<List<RecommendUserCard>> addActiveUser(WidgetRef ref) async {
  final Map<String, dynamic> queryIndex = await _fetchQueryIndex(ref);
  final String _offerableSex = queryIndex['offerableSex'];
  final List<List<int>> _chunkedAgeRange = queryIndex['chunkedAgeRange'];
  final String _livingPlace = queryIndex['livingPlace'];
  final GeoFirePoint _myLocation = queryIndex['myLocation'];
  final List<String> _offerUserIds = List<String>.from(queryIndex['offerUserIds'] ?? []);
  final List<String> _blockUserIds = List<String>.from(queryIndex['blockUserIds'] ?? []);
  final List<String> _isBlockedUserIds = List<String>.from(queryIndex['isBlockedUserIds'] ?? []);
  final int _maxDistance = queryIndex['maxDistance'];
  final DateTime _now = queryIndex['now'];
  final List<DocumentSnapshot<Map<String, dynamic>>> _recommendUserDocList = await _fetchRecommendUserDocList(
    _offerableSex,
    _chunkedAgeRange,
    _livingPlace,
    _myLocation,
    _offerUserIds,
    _blockUserIds,
    _isBlockedUserIds,
    _maxDistance,
    _now,
  );
  final List<RecommendUserCard> _recommendUserCardList = await _fetchRecommendUserCardList(
    _recommendUserDocList,
    _myLocation,
    _now,
  );
  return _recommendUserCardList;
}

Future<Map<String, dynamic>> _fetchQueryIndex(WidgetRef ref) async {
  final _uid = ref.watch(loginStatusProvider.state).state;
  final DocumentSnapshot _myDoc = await FirebaseFirestore.instance.collection('users').doc(_uid).get();
  final String _offerableSex = _myDoc['sex'] == '男性' ? '女性' : '男性';
  final _minAge = _myDoc['minAge'];
  final _maxAge = _myDoc['maxAge'] != 50 ? _myDoc['maxAge'] : 130;
  final _ageRange = List<int>.generate(_maxAge, (i) => i + 1).sublist(_minAge - 1);
  List<int> _chunk = [];
  List<List<int>> _chunkedAgeRange = [];
  for (var i = 0; i < _ageRange.length; i++) {
    _chunk.add(_ageRange[i]);
    if (_chunk.length == 10 || i == _ageRange.length - 1) {
      _chunkedAgeRange.add(_chunk);
      _chunk = [];
    }
  }
  final String _livingPlace = _myDoc['livingPlace'];
  final GeoPoint _geoPoint = _myDoc['location'];
  final GeoFirePoint _myLocation = Geoflutterfire().point(
    latitude: _geoPoint.latitude,
    longitude: _geoPoint.longitude,
  );
  final _offerUserIds = List<String>.from(_myDoc["offerUserIds"] ?? []);
  final int _maxDistance = _myDoc['maxDistance'];
  final _now = DateTime(2022, 4, 1, 15, 0); //後で変更
  return {
    'offerableSex': _offerableSex,
    'chunkedAgeRange': _chunkedAgeRange,
    'livingPlace': _livingPlace,
    'myLocation': _myLocation,
    'offerUserIds': _offerUserIds,
    'maxDistance': _maxDistance,
    'now': _now
  };
}

Future<List<DocumentSnapshot<Map<String, dynamic>>>> _fetchRecommendUserDocList(
  String offerableSex,
  List<List<int>> chunkedAgeRange,
  String livingPlace,
  GeoFirePoint myLocation,
  List<String> offerUserIds,
  List<String> blockUserIds,
  List<String> isBlockedUserIds,
  int maxDistance,
  DateTime now,
) async {
  List<String> _recommendUserIdList = [];
  List<DocumentSnapshot<Map<String, dynamic>>> _recommendUserDocList = [];
  for (var i = 0; i < chunkedAgeRange.length; i++) {
    if (myLocation.latitude != 0 && myLocation.longitude != 0) {
      final _nearMemberQueryRef = FirebaseFirestore.instance
          .collection('users')
          .where('isActive', isEqualTo: true)
          .where('sex', isEqualTo: offerableSex)
          .where('age', whereIn: chunkedAgeRange[i]);
      final _nearUserQueryStream = Geoflutterfire().collection(collectionRef: _nearMemberQueryRef).within(
            center: myLocation,
            radius: maxDistance.toDouble(),
            field: 'position',
          );
      final _nearUserQueryStreamFirst = await _nearUserQueryStream.first;
      for (var _nearUserDoc in _nearUserQueryStreamFirst) {
        await _checkAddUserDoc(
          _nearUserDoc,
          _recommendUserIdList,
          _recommendUserDocList,
          myLocation,
          offerUserIds,
          blockUserIds,
          isBlockedUserIds,
          maxDistance,
        );
      }
    }
    final _samePrefMemberQuerySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('isActive', isEqualTo: true)
        .where('sex', isEqualTo: offerableSex)
        .where('age', whereIn: chunkedAgeRange[i])
        .where('livingPlace', isEqualTo: livingPlace)
        .get();
    for (var _samePrefUserDoc in _samePrefMemberQuerySnapshot.docs) {
      await _checkAddUserDoc(
        _samePrefUserDoc,
        _recommendUserIdList,
        _recommendUserDocList,
        null,
        offerUserIds,
        blockUserIds,
        isBlockedUserIds,
        maxDistance,
      );
    }
  }
  _recommendUserDocList.shuffle();
  return _recommendUserDocList;
}

_checkAddUserDoc(
  DocumentSnapshot<Map<String, dynamic>> userDoc,
  List<String> recommendUserIdList,
  List<DocumentSnapshot<Map<String, dynamic>>> recommendUserDocList,
  GeoFirePoint? myLocation,
  List<String> offerUserIds,
  List<String> blockUserIds,
  List<String> isBlockedUserIds,
  int maxDistance,
) async {
  final GeoPoint _userLocation = userDoc['location'];
  final double _userLatitude = _userLocation.latitude;
  final double _userLongitude = _userLocation.longitude;
  final String _userPartnerId = userDoc['partner'];
  if (!recommendUserIdList.contains(userDoc.id) &&
      !recommendUserIdList.contains(_userPartnerId) &&
      !offerUserIds.contains(userDoc.id) &&
      !offerUserIds.contains(_userPartnerId) &&
      !blockUserIds.contains(userDoc.id) &&
      !blockUserIds.contains(_userPartnerId) &&
      !isBlockedUserIds.contains(userDoc.id) &&
      !isBlockedUserIds.contains(_userPartnerId)) {
    if (myLocation != null) {
      if (_userLatitude == 0 && _userLongitude == 0) return;
      final double _userDistance = distanceBetween(
        myLocation.latitude,
        myLocation.longitude,
        _userLatitude,
        _userLongitude,
      );
      if (_userDistance > maxDistance * 1000) return;
    }
    recommendUserIdList.add(userDoc.id);
    recommendUserDocList.add(userDoc);
    if (_userPartnerId != '') {
      recommendUserIdList.add(_userPartnerId);
    }
  }
}

Future<List<RecommendUserCard>> _fetchRecommendUserCardList(
  List<DocumentSnapshot<Map<String, dynamic>>> recommendUserDocList,
  GeoFirePoint myLocation,
  DateTime now,
) async {
  List<RecommendUserCard> _recommendUserCardList = [];
  for (var recommendUserDoc in recommendUserDocList) {
    final String _user1Id = recommendUserDoc.id;
    final double _myLatitude = myLocation.latitude;
    final double _myLongitude = myLocation.longitude;
    final GeoPoint _user1Location = recommendUserDoc['location'];
    final double _user1Latitude = _user1Location.latitude;
    final double _user1Longitude = _user1Location.longitude;
    final double _user1Distance = ((_myLatitude == 0 && _myLongitude == 0) || (_user1Latitude == 0 && _user1Longitude == 0))
        ? 0
        : distanceBetween(
              _myLatitude,
              _myLongitude,
              _user1Location.latitude,
              _user1Location.longitude,
            ) /
            1000;
    final String _user1NickName = recommendUserDoc['nickName'];
    final int _user1Age = recommendUserDoc['age'];
    final String _user1LivingPlace = recommendUserDoc['livingPlace'];
    final String _user1Status = '$_user1Age歳・$_user1LivingPlace';
    final DateTime _user1ActveTime = recommendUserDoc['activeTime'].toDate();
    final String _user2Id = recommendUserDoc['partner'];
    double _user2Distance = 0;
    String _user2NickName = 'ゲスト';
    String _user2Status = 'ゲスト';
    DateTime _user2ActveTime = _user1ActveTime;
    if (_user2Id != '') {
      final DocumentSnapshot _user2Doc = await FirebaseFirestore.instance.collection('users').doc(_user2Id).get();
      final GeoPoint _user2Location = _user2Doc['location'];
      final double _user2Latitude = _user2Location.latitude;
      final double _user2Longitude = _user2Location.longitude;
      _user2Distance = ((_myLatitude == 0 && _myLongitude == 0) || (_user2Latitude == 0 && _user2Longitude == 0))
          ? 0
          : distanceBetween(
                _myLatitude,
                _myLongitude,
                _user2Latitude,
                _user2Longitude,
              ) /
              1000;
      _user2NickName = _user2Doc['nickName'];
      final int _user2Age = _user2Doc['age'];
      final String _user2LivingPlace = _user2Doc['livingPlace'];
      _user2Status = '$_user2Age歳・$_user2LivingPlace';
      _user2ActveTime = _user2Doc['activeTime'].toDate();
    }
    final DateTime _activeTime = _user1ActveTime.isAfter(_user2ActveTime) ? _user1ActveTime : _user2ActveTime;
    final bool _isActiveTime = _activeTime.isBefore(now);
    final String _status = _isActiveTime ? 'オファー受付中' : 'オファー開始 ${_activeTime.hour}:${_activeTime.minute.toString().padLeft(2, '0')}';
    _recommendUserCardList.add(
      RecommendUserCard(
        user1Id: _user1Id,
        user1Distance: _user1Distance,
        user1NickName: _user1NickName,
        user1Status: _user1Status,
        user2Id: _user2Id,
        user2Distance: _user2Distance,
        user2NickName: _user2NickName,
        user2Status: _user2Status,
        status: _status,
        isActiveTime: _isActiveTime,
      ),
    );
    _recommendUserCardList.sort(
      (a, b) {
        return a.status.compareTo(b.status);
      },
    );
  }
  return _recommendUserCardList;
}
