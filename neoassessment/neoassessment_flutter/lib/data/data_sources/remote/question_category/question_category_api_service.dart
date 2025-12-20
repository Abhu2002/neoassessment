import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/sharedPref.dart';

abstract class QuestionCategoryApiService {
  QuestionCategoryApiService(Dio dio);

  Future<Response<dynamic>> getQuestionCategory();

  Future<Response<dynamic>> deleteQuestionCategory(int questioncategoryId);

  Future<Response<dynamic>> createQuestionCategory(
      int domainId, String name, String description);

  Future<Response<dynamic>> updateQuestionCategory(
      int id, int domainId, String name, String description);
}

class QuestionCategoryApiServiceImpl extends QuestionCategoryApiService {
  QuestionCategoryApiServiceImpl(super.dio);

  @override
  Future<Response> getQuestionCategory() async {
    String? token = Prefs.getAccessToken();

    var headers = {
      'Access-Token': token,
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'no-skip'
    };
    //var data = json.encode({"method": "getQuestionCategory"});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/questionCategory?method=getQuestionCategory',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      //data: data,
    );

    return response;
  }

  @override
  Future<Response> deleteQuestionCategory(int questioncategoryId) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json
        .encode({"method": "delete", "questioncategoryId": questioncategoryId});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/questionCategory',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> createQuestionCategory(
      int domainId, String name, String description) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "create",
      "questioncategory": {
        "domain_id": domainId,
        "name": name,
        "description": description
      }
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/questionCategory',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> updateQuestionCategory(
      int id, int domainId, String name, String description) async {
    String? token = Prefs.getAccessToken();

    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "update",
      "questCatId": id,
      "questionCat": {
        "domain_id": domainId,
        "name": name,
        "description": description
      }
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/questionCategory',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    return response;
  }
}
