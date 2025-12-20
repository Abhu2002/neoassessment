import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/sharedPref.dart';

abstract class UsersApiService {
  UsersApiService(Dio dio);

  Future<Response<dynamic>> login(String email, String password);

  Future<Response<dynamic>> getUsers();

  Future<Response<dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required DateTime dob,
    required int domainId,
    required int roleId,
    required int experience,
    required String password,
  });

  Future<Response<dynamic>> deleteUser(int userId);

  Future<Response<dynamic>> updateUser(
      int userId,
      String firstName,
      String lastName,
      String email,
      String phone,
      DateTime dob,
      int domainId,
      int roleId,
      int exp,
      String password);

  Future<Response<dynamic>> getSingleUser(int userId);
  Future<Response<dynamic>> verifyToken(String tokenData);
}

class UsersApiServiceImpl extends UsersApiService {
  UsersApiServiceImpl(super.dio);

  @override
  Future<Response> login(String email, String password) async {
    var headers = {
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'no-skip'
    };
    var data =
        json.encode({"method": "login", "email": email, "password": password});
    var dio = GetIt.I.get<Dio>();
    var response = await dio.request(
      '${Constants.baseUrl}/user',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    return response;
  }

  @override
  Future<Response> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required DateTime dob,
    required int domainId,
    required int roleId,
    required int experience,
    required String password,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "register",
      "user": {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "dob": "$dob",
        "domain_id": domainId,
        "role_id": roleId,
        "experience": experience,
        "password": password
      }
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/user',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> getUsers() async {
    var headers = {
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'no-skip'
    };
    // var data = json.encode({"method": "getUsers"});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/user?method=getUsers',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      // data: data,
    );

    return response;
  }

  @override
  Future<Response> deleteUser(int userId) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({"method": "deleteUser", "userId": userId});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/user',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> updateUser(
      int userId,
      String firstName,
      String lastName,
      String email,
      String phone,
      DateTime dob,
      int domainId,
      int roleId,
      int exp,
      String password) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "updateUser",
      "userId": userId,
      "user": {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "dob": "$dob",
        "domain_id": domainId,
        "role_id": roleId,
        "experience": exp,
        "password": password
      }
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/user',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> verifyToken(String tokenData) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"method": "verifyToken", "tokenData": tokenData});
    var dio = Dio();

    var response = await dio.request(
      '${Constants.baseUrl}/user',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    //print(response);

    return response;
  }

  @override
  Future<Response> getSingleUser(int userId) async {
    String? token = Prefs.getAccessToken();
    var headers = {
      'Access-Token': token,
      'ngrok-skip-browser-warning': 'no-skip',
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "method": "getSingleUser",
      "userId": userId
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/user',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }
}
