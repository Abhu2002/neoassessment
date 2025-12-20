import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/status/status_api_service.dart';
import 'package:neoassessment_flutter/domain/entities/status/status_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/status/status_repository.dart';

class StatusRepoImpl extends StatusRepository {
  final StatusApiService _statusApiService;

  StatusRepoImpl(this._statusApiService);

  @override
  Future<DataState<String>> createStatus(StatusEntity statusEntity) async {
    try {
      final response = await _statusApiService.createStatus(statusEntity);
      if (response.data['status'] == 200) {
        return DataSuccess(response.data['message'], response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            message: response.data['user_msg'],
            error: response.data['user_msg'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> deleteStatus(StatusEntity statusEntity) async {
    try {
      final response = await _statusApiService.deleteStatus(statusEntity);
      if (response.data['status'] == 200) {
        return DataSuccess(response.data['message'], response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            message: response.data['user_msg'],
            error: response.data['user_msg'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<StatusEntity>>> getStatus() async {
    try {
      final response = await _statusApiService.getStatus();
      if (response.data['status'] == 200) {
        List<StatusEntity> status = [];
        for (var st in response.data['body']) {
          status.add(StatusEntity.fromJson(st));
        }
        return DataSuccess(status, response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            message: response.data['user_msg'],
            error: response.data['user_msg'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> updateStatus(StatusEntity statusEntity) async {
    try {
      final response = await _statusApiService.updateStatus(statusEntity);
      if (response.data['status'] == 200) {
        return DataSuccess(response.data['message'], response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            message: response.data['user_msg'],
            error: response.data['user_msg'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
