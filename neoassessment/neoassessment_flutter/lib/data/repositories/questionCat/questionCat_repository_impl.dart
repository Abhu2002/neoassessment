import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/question_category/question_category_api_service.dart';
import 'package:neoassessment_flutter/data/models/question_cat/question_category_model.dart';
import 'package:neoassessment_flutter/domain/entities/questionCat/questionCat_entity.dart';

import '../../../domain/repositories/questionCat/questionCat_repository.dart';

class QuestionCatRepositoryImpl extends QuestionCategoryRepository {
  final QuestionCategoryApiService _questionApiService;

  QuestionCatRepositoryImpl(this._questionApiService);

  @override
  Future<DataState<List<QuestionCatModel>>> getQuestionCat() async {
    try {
      final response = await _questionApiService.getQuestionCategory();

      if (response.data['status'] == 200) {
        List<QuestionCatModel> result = [];
        for (var res in response.data["body"]) {
          result.add(QuestionCatModel.fromJson(res));
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
  Future<DataState<String>> deleteQuestionCat(
      QuestionCatEntity questionCat) async {
    try {
      final response =
          await _questionApiService.deleteQuestionCategory(questionCat.id!);
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
  Future<DataState<String>> createQuestionCat(
      QuestionCatEntity questionCat) async {
    try {
      final response = await _questionApiService.createQuestionCategory(
          questionCat.domainId!, questionCat.name!, questionCat.description!);
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
  Future<DataState<String>> updateQuestionCat(
      QuestionCatEntity questionCat) async {
    try {
      final response = await _questionApiService.updateQuestionCategory(
          questionCat.id!,
          questionCat.domainId!,
          questionCat.name!,
          questionCat.description!);
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
