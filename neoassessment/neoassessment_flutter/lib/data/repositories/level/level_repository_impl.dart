import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/level/level_api_service.dart';
import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/level/level_repository.dart';

import '../../models/level/level_model.dart';

class LevelRepositoryImpl extends LevelRepository {
  final LevelApiService _levelApiService;

  LevelRepositoryImpl(this._levelApiService);

  @override
  Future<DataState<List<LevelModel>>> getLevels() async {
    try {
      final response = await _levelApiService.getLevels();
      if (response.data['status'] == 200) {
        List<LevelModel> result = [];
        for (var res in response.data["body"]) {
          result.add(LevelModel.fromJson(res));
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
  Future<DataState<String>> createLevels(LevelEntity level) async {
    try {
      final response = await _levelApiService.createLevels(level.number!);
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
  Future<DataState<String>> deleteLevels(LevelEntity level) async {
    try {
      final response = await _levelApiService.deleteLevels(level.id!);
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
  Future<DataState<String>> updateLevels(LevelEntity level) async {
    try {
      final response =
          await _levelApiService.updateLevels(level.id!, level.number!);
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
