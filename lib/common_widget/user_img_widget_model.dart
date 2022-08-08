import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

// プロフ画像のIDとURLを取得する関数
Future<Map<String, String>> fetchUserImg(String userId, int index) async {
  String _imageId = '';
  String _imageUrl = '';
  if (userId != '') {
    final _userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    List<String> _imageIds = ['', '', '', '', ''];
    try {
      final _imageIdsTmp = List<String>.from(_userDoc['imageIds']);
      for (var i = 0; i < 5; i++) {
        try {
          _imageIds[i] = _imageIdsTmp[i];
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    try {
      _imageId = _imageIds[index];
      try {
        _imageUrl = await FirebaseStorage.instance.ref('/profile/' + userId + '/' + _imageId + '.jpeg').getDownloadURL();
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  return {
    'imageId': _imageId,
    'imageUrl': _imageUrl,
  };
}
