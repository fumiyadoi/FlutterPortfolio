import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> fetchUserInfo(String userId) async {
  String nickName = '';
  String age = '';
  String comment = '';
  List<String> personalTags = [];
  String introduction = '';
  String bloodType = '';
  String siblings = '';
  String livingPlace = '';
  String country = '';
  String language = '';
  String height = '';
  String bodyShape = '';
  String alcohol = '';
  String tobacco = '';
  String familyType = '';
  String academic = '';
  String industry = '';
  String occupation = '';
  String workLocation = '';
  String annualIncome = '';
  String holidays = '';
  if (userId != '') {
    final _userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    nickName = _userDoc['nickName'];
    age = _userDoc['age'].toString();
    comment = _userDoc['comment'];
    personalTags = List<String>.from(_userDoc['personalTags']);
    introduction = _userDoc['introduction'];
    bloodType = _userDoc['bloodType'];
    siblings = _userDoc['siblings'];
    livingPlace = _userDoc['livingPlace'];
    country = _userDoc['country'];
    language = _userDoc['language'];
    height = _userDoc['height'];
    bodyShape = _userDoc['bodyShape'];
    alcohol = _userDoc['alcohol'];
    tobacco = _userDoc['tobacco'];
    familyType = _userDoc['familyType'];
    academic = _userDoc['academic'];
    industry = _userDoc['industry'];
    occupation = _userDoc['occupation'];
    workLocation = _userDoc['workLocation'];
    annualIncome = _userDoc['annualIncome'];
    holidays = _userDoc['holidays'];
  }
  return {
    'nickName': nickName,
    'age': age,
    'comment': comment,
    'personalTags': personalTags,
    'introduction': introduction,
    'bloodType': bloodType,
    'siblings': siblings,
    'livingPlace': livingPlace,
    'country': country,
    'language': language,
    'height': height,
    'bodyShape': bodyShape,
    'alcohol': alcohol,
    'tobacco': tobacco,
    'familyType': familyType,
    'academic': academic,
    'industry': industry,
    'occupation': occupation,
    'workLocation': workLocation,
    'annualIncome': annualIncome,
    'holidays': holidays,
  };
}
