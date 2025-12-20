import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/constants/constants.dart';

import '../../../../core/utils/sharedPref.dart';
import '../../../../domain/entities/candidates/candidate_entity.dart';

abstract class CandidateApiService {
  CandidateApiService(Dio dio);

  Future<Response<dynamic>> registerCandidate(CandidateEntity candidateEntity);

  Future<Response<dynamic>> loginCandidate(CandidateEntity candidateEntity);

  Future<Response<dynamic>> updateCandidate(CandidateEntity candidateEntity);

  Future<Response<dynamic>> deleteCandidate(int candidateId);

  Future<Response<dynamic>> getCandidates();

  Future<Response<dynamic>> getSingleCandidate(int candidateId);
}

class CandidateApiServiceImpl extends CandidateApiService {
  CandidateApiServiceImpl(super.dio);

  @override
  Future<Response> deleteCandidate(int candidateId) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data =
        json.encode({"method": "deleteCandidate", "candidateId": candidateId});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/candidate',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> getCandidates() async {
    String? token = Prefs.getAccessToken();
    var headers = {
      'Access-Token': token,
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'no-skip'
    };
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/candidate?method=getallCandidates',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    return response;
  }

  @override
  Future<Response> loginCandidate(CandidateEntity candidateEntity) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "loginCandidate",
      "email": candidateEntity.email,
      "password": candidateEntity.password
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/candidate',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> registerCandidate(CandidateEntity candidateEntity) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "register",
      "candidate": {
        "first_name": candidateEntity.firstName,
        "last_name": candidateEntity.lastName,
        "email": candidateEntity.email,
        "phone": candidateEntity.phone,
        "dob": "${candidateEntity.dob}",
        "domain_id": candidateEntity.domainId,
        "experience": candidateEntity.experience,
        "password": candidateEntity.password,
      }
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/candidate',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> updateCandidate(CandidateEntity candidateEntity) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "updateCandidate",
      "candidateId": candidateEntity.id,
      "candidate": {
        "first_name": candidateEntity.firstName,
        "last_name": candidateEntity.lastName,
        "email": candidateEntity.email,
        "phone": candidateEntity.phone,
        "dob": "${candidateEntity.dob}",
        "domain_id": candidateEntity.domainId,
        "experience": candidateEntity.experience,
        "password": candidateEntity.password,
      }
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/candidate',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> getSingleCandidate(int candidateId) async {
    String? token = Prefs.getAccessToken();
    var headers = {
      'ngrok-skip-browser-warning': 'no-skip',
      'Access-Token': token,
      'Content-Type': 'application/json'
    };
    var data = json
        .encode({"method": "getSingleCandidate", "candidateId": candidateId});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/candidate',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }
}
