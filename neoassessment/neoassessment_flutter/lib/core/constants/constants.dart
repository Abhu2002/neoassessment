import 'package:flutter/material.dart';

class Constants {
  static String baseUrl = "https://3b2a-125-99-115-211.ngrok-free.app";
  static Color pageBackgroundColor = Colors.white70;
}

extension StringCheck on String? {
  bool get isValidName {
    if (this == null || this!.isEmpty) return false;
    final nameRegExp = RegExp(r"^[A-Za-z][A-Za-z0-9_ ]{2,30}$");
    return nameRegExp.hasMatch(this!);
    //return true;
  }
}
