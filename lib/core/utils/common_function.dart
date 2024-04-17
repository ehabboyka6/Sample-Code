import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

bool checkPattern({pattern, value}) {
  RegExp regularCheck = RegExp(pattern);
  return regularCheck.hasMatch(value);
}
String enumToString(Object o) => o.toString().split('.').last;
bool isArabic(String text) {
  if (RegExp(r"^[\s\d\.\,\،\-a-zA-Zء-ي]*$").hasMatch(text)) {
    if (kDebugMode) {
      print('isArabic');
    }
    return true;
  } else {
    if (kDebugMode) {
      print('isNotArabic');
    }
    return false;
  }
}
T? enumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhereOrNull((type) => type.toString().split(".").last == value);
}