import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/constants/constants.dart';
import 'package:neoassessment_flutter/domain/entities/response/response_entity.dart';

import '../../../../core/utils/sharedPref.dart';

abstract class ResponseApiService {
  ResponseApiService(Dio dio);

  Future<Response> saveResponse(ResponseEntity responseEntity);

  Future<Response> updateResponse(ResponseEntity responseEntity);

  Future<Response> deleteResponse(ResponseEntity responseEntity);

  Future<Response> getResponses();
}

class ResponseApiServiceImpl extends ResponseApiService {
  ResponseApiServiceImpl(super.dio);

  @override
  Future<Response> deleteResponse(ResponseEntity responseEntity) async {
    String? token = Prefs.getAccessToken();
    var headers = {
      'Access-Token': token,
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "method": "deleteResponse",
      "responseId": responseEntity.id
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/response',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> getResponses() async {
    String? token = Prefs.getAccessToken();
    var headers = {
      'Access-Token': token,
      'ngrok-skip-browser-warning': 'no-skip',
      'Content-Type': 'application/json'
    };
    // var data = json.encode({
    //   "method": "getAllResponses"
    // });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/response?method=getAllResponses',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      // data: data,
    );

    return response;
  }

  @override
  Future<Response> saveResponse(ResponseEntity responseEntity) async {
    String? token = Prefs.getAccessToken();
    var headers = {
      'Access-Token': token,
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "method": "saveResponse",
      "response": {
        "candidate_id": responseEntity.candidateId,
        "exam_id": responseEntity.examId,
        "assign_by": responseEntity.assignBy,
        "q_ids": responseEntity.qIds ?? [],
        "response": responseEntity.response ?? [],
        "reviewed_by": responseEntity.response,
        "score": responseEntity.score ?? 0,
        "status": responseEntity.statusId,
      }
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/response',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> updateResponse(ResponseEntity responseEntity) async {
    String? token = Prefs.getAccessToken();
    var headers = {
      'Access-Token': token,
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "method": "updateResponseInfo",
      "statusId": responseEntity.statusId,
      "responseId": responseEntity.id,
      "reviewerId": responseEntity.reviewedBy
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/response',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    return response;
  }

}
