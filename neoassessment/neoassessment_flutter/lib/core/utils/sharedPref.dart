import 'dart:convert';

import 'package:neoassessment_flutter/data/models/domains/domain_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static final Prefs _singleton = Prefs._internal();

  factory Prefs() {
    return _singleton;
  }

  Prefs._internal();

  static SharedPreferences? _preferences;

  static const _keyUser = 'user';
  static const access_token = 'accessToken';
  static const domains = 'domains';
  static const levels = 'levels';
  static const userId = 'userId';

  static Future clearAllPreference() => _preferences!.clear();

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(String? val) async =>
      await _preferences!.setString(_keyUser, val!);

  static String? getUser() => _preferences?.getString(_keyUser);

  static Future setUserId(int? val) async =>
      await _preferences!.setInt(userId, val!);

  static int? getUserId() => _preferences?.getInt(userId);

  static Future<bool>? deleteUser() => _preferences?.remove(_keyUser);

  static Future setAccessToken(String? val) async =>
      await _preferences!.setString(access_token, val!);

  static String? getAccessToken() => _preferences?.getString(access_token);

  static Future<bool>? deleteAccessToken() =>
      _preferences?.remove(access_token);

  static Future setDomains(List<DomainModel> allDomains) async {
    String datas = jsonEncode(allDomains);
    return await _preferences?.setString(domains, datas);
  }

  static Future<List<DomainModel>?> getDomains() async {
    try {
      var datas = await _preferences!.getString(domains);
      if (datas == null && datas! is List) {
        return null;
      }
      List newData = jsonDecode(datas) as List;
      List<DomainModel> data = [];

      for (var res in newData) {
        data.add(DomainModel.fromJson(res));
      }
      return data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future deleteDomains() => _preferences!.remove(domains);
}
