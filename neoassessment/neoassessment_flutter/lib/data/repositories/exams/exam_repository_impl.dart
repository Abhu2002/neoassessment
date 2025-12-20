import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/exams/exams_api_service.dart';
import 'package:neoassessment_flutter/data/models/exams/exam_model.dart';
import 'package:neoassessment_flutter/domain/entities/exams/exam_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/exams/exam_repository.dart';

class ExamRepositoryImpl extends ExamRepository {
  final ExamApiService _examApiService;

  ExamRepositoryImpl(this._examApiService);

  @override
  Future<DataState<String>> createExam(ExamEntity examEntity) async {
    try {
      final response = await _examApiService.createExam(examEntity);

      if (response.data['status'] == 200) {
        String message = response.data['user_msg'];
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
  Future<DataState<List<ExamEntity>>> getExams() async  {
   try{
     final response = await _examApiService.getExams();
     if(response.data['status'] == 200){
       List<ExamModel> result = [];
       for (var res in response.data["body"]) {
         result.add(ExamModel.fromJson(res));

       }
       return DataSuccess(result, response.data['user_msg']);
     }else {
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
  Future<DataState<String>> deleteExams(ExamEntity examEntity) async  {

    try{
      final response = await _examApiService.deleteExams(examEntity.id!);
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
