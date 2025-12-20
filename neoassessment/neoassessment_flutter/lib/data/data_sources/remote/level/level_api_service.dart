import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/sharedPref.dart';

abstract class LevelApiService {
  LevelApiService(Dio dio);

  Future<Response<dynamic>> getLevels();

  Future<Response<dynamic>> createLevels(int level);

  Future<Response<dynamic>> deleteLevels(int levelId);

  Future<Response<dynamic>> updateLevels(int levelId, int newlevelNumber);
}

class LevelApiServiceImpl extends LevelApiService {
  LevelApiServiceImpl(super.dio);

  @override
  Future<Response<dynamic>> getLevels() async {
    String? token = Prefs.getAccessToken();

    var headers = {
      'Access-Token': token,
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'no-skip'
    };
    // var data = json.encode({"method": "getLevels"});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/level?method=getLevels',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      // data: data,
    );

    return response;
  }

  @override
  Future<Response<dynamic>> createLevels(int level) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "create",
      "level": {"number": level}
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/level',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response<dynamic>> deleteLevels(int levelId) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({"method": "delete", "levelId": levelId});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/level',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> updateLevels(int levelId, int newlevelNumber) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "update",
      "levelId": levelId,
      "level": {"number": newlevelNumber}
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/level',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }
}
