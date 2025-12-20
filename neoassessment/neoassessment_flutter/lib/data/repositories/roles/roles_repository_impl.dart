import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/roles/roles_api_service.dart';
import 'package:neoassessment_flutter/domain/entities/roles/role_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/roles/roles_repository.dart';

import '../../models/roles/role_model.dart';

class RolesRepositoryImpl implements RolesRepository {
  final RolesApiService _rolesApiService;

  RolesRepositoryImpl(this._rolesApiService);

  @override
  Future<DataState<List<RoleModel>>> getRoles() async {
    try {
      final response = await _rolesApiService.getRoles();
      if (response.data['status'] == 200) {
        List<RoleModel> result = [];
        for (var res in response.data["body"]) {
          result.add(RoleModel.fromJson(res));
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
  Future<DataState<String>> createRole(RoleEntity role) async {
    try {
      final response = await _rolesApiService.createRoles(role.name!);
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
  Future<DataState<String>> deleteRoles(RoleEntity role) async {
    try {
      final response = await _rolesApiService.deleteRoles(role.id!);
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
  Future<DataState<String>> updateRoles(RoleEntity role) async {
    try {
      final response = await _rolesApiService.updateRoles(role.id!, role.name!);
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
