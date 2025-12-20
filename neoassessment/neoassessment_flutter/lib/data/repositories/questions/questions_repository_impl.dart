import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/questions/question_api_service.dart';
import 'package:neoassessment_flutter/data/models/questions/question_model.dart';
import 'package:neoassessment_flutter/domain/entities/questions/questions_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/questions/questions_repository.dart';

class QuestionsRepositoryImpl extends QuestionsRepository {
  final QuestionApiService _questionApiService;

  QuestionsRepositoryImpl(this._questionApiService);

  @override
  Future<DataState<List<QuestionEntity>>> getQuestions() async {
    try {
      final response = await _questionApiService.getQuestions();

      if (response.data['status'] == 200) {
        List<QuestionModel> result = [];
        for (var res in response.data["body"]) {
          result.add(QuestionModel.fromJson(res));
        }
        return DataSuccess(result, response.data['user_msg']);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          message: response.data['message'],
          error: response.data['status'],
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> deleteQuestion(
      QuestionEntity questionEntity) async {
    try {
      final response =
          await _questionApiService.deleteQuestion(questionEntity.id!);

      if (response.data['status'] == 200) {
        String message;
        message = response.data["user_msg"];
        return DataSuccess(message, message);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          message: response.data['message'],
          error: response.data['status'],
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> createQuestion(
      QuestionEntity questionEntity) async {
    try {
      final response = await _questionApiService.createQuestion(questionEntity);

      if (response.data['status'] == 200) {
        String message;
        message = response.data["user_msg"];
        return DataSuccess(message, message);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          message: response.data['message'],
          error: response.data['status'],
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> updateQuestion(
      QuestionEntity questionEntity) async {
    try {
      final response = await _questionApiService.updateQuestion(questionEntity);

      if (response.data['status'] == 200) {
        String message;
        message = response.data["user_msg"];
        return DataSuccess(message, message);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          message: response.data['message'],
          error: response.data['status'],
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
