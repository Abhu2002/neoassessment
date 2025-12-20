import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/constants/constants.dart';
import 'package:neoassessment_flutter/domain/entities/questions/questions_entity.dart';

import '../../../../core/utils/sharedPref.dart';

abstract class QuestionApiService {
  QuestionApiService(Dio dio);

  Future<Response> getQuestions();

  Future<Response> deleteQuestion(int id);

  Future<Response> createQuestion(QuestionEntity questionModel);

  Future<Response> updateQuestion(QuestionEntity questionModel);
}

class QuestionApiServiceImpl extends QuestionApiService {
  QuestionApiServiceImpl(super.dio);

  @override
  Future<Response> getQuestions() async {
    var headers = {
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'no-skip'
    };
    //  var data = json.encode({"method": "getQuestion"});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/question?method=getQuestion',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      // data: data,
    );

    return response;
  }

  @override
  Future<Response> deleteQuestion(int id) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({"method": "delete", "questionId": id});
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/question',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> createQuestion(QuestionEntity questionModel) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "create",
      "question": {
        "domain_id": questionModel.domainId,
        "level_id": questionModel.levelId,
        "question": questionModel.question,
        "question_category_id": questionModel.questionCategoryId,
        "op1": questionModel.op1,
        "op2": questionModel.op2,
        "op3": questionModel.op3,
        "op4": questionModel.op4,
        "correct_op": questionModel.correctOp,
      }
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/question',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> updateQuestion(QuestionEntity questionModel) async {
    String? token = Prefs.getAccessToken();
    var headers = {'Access-Token': token, 'Content-Type': 'application/json'};
    var data = json.encode({
      "method": "updateQuestion",
      "questId": questionModel.id,
      "question": {
        "domain_id": questionModel.domainId,
        "level_id": questionModel.levelId,
        "question": questionModel.question,
        "question_category_id": questionModel.questionCategoryId,
        "op1": questionModel.op1,
        "op2": questionModel.op2,
        "op3": questionModel.op3,
        "op4": questionModel.op4,
        "correct_op": questionModel.correctOp
      }
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/question',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }
}
