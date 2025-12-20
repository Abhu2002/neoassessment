import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/constants/constants.dart';

abstract class DomainsApiService {
  DomainsApiService(Dio dio);

  Future<Response<dynamic>> getDomains();

  Future<Response<dynamic>> createDomain(String name, String description);

  Future<Response<dynamic>> updateDomain(
      int domainId, String name, String description);

  Future<Response<dynamic>> deleteDomain(int domainId);
}

class DomainsApiServiceImpl extends DomainsApiService {
  DomainsApiServiceImpl(super.dio);

  @override
  Future<Response<dynamic>> getDomains() async {
    var headers = {
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'no-skip'
    };
    // var data = json.encode({"method": "getDomains"});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/domain?method=getDomains',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      // data: data,
    );

    return response;
  }

  @override
  Future<Response> createDomain(String name, String description) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "create",
      "domain": {"name": name, "description": description}
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/domain',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> updateDomain(
      int domainId, String name, String description) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "update",
      "domainId": domainId,
      "newdomain": name,
      "newdescription": description
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/domain',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> deleteDomain(int domainId) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"method": "delete", "domainId": domainId});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/domain',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }
}
