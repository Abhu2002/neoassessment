import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';

abstract class RolesApiService {
  RolesApiService(Dio dio);

  Future<Response<dynamic>> getRoles();

  Future<Response<dynamic>> createRoles(String rolename);

  Future<Response<dynamic>> deleteRoles(int roleId);

  Future<Response<dynamic>> updateRoles(int roleId, String newRoleName);
}

class RoleApiServiceImpl extends RolesApiService {
  RoleApiServiceImpl(super.dio);

  @override
  Future<Response<dynamic>> getRoles() async {
    var headers = {
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'no-skip'
    };
    //var data = json.encode({"method": "getRoles"});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/role?method=getRoles',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      //   data: data,
    );

    return response;
  }

  @override
  Future<Response<dynamic>> createRoles(String rolename) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "create",
      "role": {"name": rolename}
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/role',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    return response;
  }

  @override
  Future<Response<dynamic>> deleteRoles(int roleId) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"method": "delete", "roleId": roleId});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/role',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    return response;
  }

  @override
  Future<Response<dynamic>> updateRoles(int roleId, String newRoleName) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json
        .encode({"method": "update", "roleId": roleId, "newRole": newRoleName});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/role',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }
}
