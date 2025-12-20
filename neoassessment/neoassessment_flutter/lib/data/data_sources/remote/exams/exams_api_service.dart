import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/constants/constants.dart';
import 'package:neoassessment_flutter/domain/entities/exams/exam_entity.dart';

import '../../../../core/utils/sharedPref.dart';

abstract class ExamApiService {
  ExamApiService(Dio dio);

  Future<Response<dynamic>> createExam(ExamEntity examModel);

  Future<Response<dynamic>> getExams();

  Future<Response<dynamic>> deleteExams(int examId);
}

class ExamApiServiceImpl extends ExamApiService {
  ExamApiServiceImpl(super.dio);

  @override
  Future<Response> createExam(ExamEntity examModel) async {
    String? token = Prefs.getAccessToken();
    var headers = {
      'Access-Token': token,
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "method": "create",
      "exam": {
        "name": examModel.name,
        "description": examModel.description,
        "domain_id": examModel.domainId,
        "no_of_questions": examModel.noOfQuestions,
        "level": examModel.level,
        "question_ids": examModel.questionIds,
        "passing_score": examModel.passingScore
      }
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/exam',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;
  }

  @override
  Future<Response> getExams() async {
    String? token = Prefs.getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'no-skip',
      'Access-Token': token
    };

    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/exam?method=getExams',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    return response;
  }

  @override
  Future<Response> deleteExams(int examId) async {
    String? token = Prefs.getAccessToken();
    var headers = {
      'Access-Token': token,
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "method": "delete",
      "examId": examId
    });
    var dio = Dio();
    var response = await dio.request(
      '${Constants.baseUrl}/exam',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    return response;

  }
}
