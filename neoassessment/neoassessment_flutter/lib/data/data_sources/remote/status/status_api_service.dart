import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/constants/constants.dart';

import '../../../../core/utils/sharedPref.dart';
import '../../../../domain/entities/status/status_entity.dart';

abstract class StatusApiService {
  StatusApiService(Dio dio);

  Future<Response<dynamic>> createStatus(StatusEntity statusModel);

  Future<Response<dynamic>> updateStatus(StatusEntity statusModel);

  Future<Response<dynamic>> getStatus();

  Future<Response<dynamic>> deleteStatus(StatusEntity statusModel);
}

class StatusApiServiceImpl extends StatusApiService {
  StatusApiServiceImpl(super.dio);

  @override
  Future<Response> createStatus(StatusEntity statusModel) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "create",
      "status": {"name": statusModel.status}
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/status',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> deleteStatus(StatusEntity statusModel) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Content-Type': 'application/json', 'Access-Token': token};
    var data = json.encode({"method": "delete", "statusId": statusModel.id});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/status',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> getStatus() async {
    String? token = Prefs.getAccessToken();
    var headers = {
      'Access-Token': token,
      'ngrok-skip-browser-warning': 'no-skip'
    };
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/status?method=getStatus',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    return response;
  }

  @override
  Future<Response> updateStatus(StatusEntity statusModel) async {
    String? token = Prefs.getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Access-Token': token
    };
    var data = json.encode({
      "method": "update",
      "statusId": statusModel.id,
      "status": {"name": statusModel.status}
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/status',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }
}
