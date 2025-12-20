import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/response/response_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/responses/response_repository.dart';

import '../../data_sources/remote/responses/response_api_service.dart';

class ResponseRepoImpl extends ResponseRepository {
  final ResponseApiService _responseApiService;

  ResponseRepoImpl(this._responseApiService);

  @override
  Future<DataState<String>> deleteResponse(
      ResponseEntity responseEntity) async {
    try {
      final response = await _responseApiService.deleteResponse(responseEntity);
      if (response.data['status'] == 200) {
        return DataSuccess(
            response.data['user_msg'], response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            message: response.data['message'],
            error: response.data['user_msg'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ResponseEntity>>> getResponses() async {
    try {
      final response = await _responseApiService.getResponses();
      List<ResponseEntity> responses = [];
      if (response.data['status'] == 200) {
        for (var response in response.data['body']) {
          responses.add(ResponseEntity.fromJson(response));
        }

        return DataSuccess(responses, response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            error: response.data['message'],
            message: response.data['message'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> saveResponse(ResponseEntity responseEntity) async {
    try {
      final response = await _responseApiService.saveResponse(responseEntity);
      if (response.data['status'] == 200) {
        return DataSuccess(response.data['message'], response.data['user_msg']);
      } else {
        return DataFailed(DioException(
          response: Response(
            data: response.data['message'],
            requestOptions: response.requestOptions,
          ),
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
  Future<DataState<String>> updateResponse(
      ResponseEntity responseEntity) async {
    try {
      final response = await _responseApiService.updateResponse(responseEntity);
      if (response.data['status'] == 200) {
        return DataSuccess(
            response.data['user_msg'], response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            message: response.data['message'],
            error: response.data['user_msg'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
