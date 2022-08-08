import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textProvider = StateProvider<String>((ref) {
  return '';
});

final controllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController(text: '');
});
