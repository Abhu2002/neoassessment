import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/users/users_api_service.dart';
import 'package:neoassessment_flutter/data/models/users/user_model.dart';
import 'package:neoassessment_flutter/domain/entities/users/user_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/users/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  final UsersApiService _usersApiService;

  UsersRepositoryImpl(this._usersApiService);

  @override
  Future<DataState<UserModel>> loginUser(UserEntity user) async {
    try {
      final response =
          await _usersApiService.login(user.email!, user.password!);
      if (response.data['status'] == 200) {
        var body = response.data['body'];
        UserModel userModel = UserModel.fromJson(body[0]);
        return DataSuccess(userModel, response.data['user_msg']);
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
  Future<DataState<UserEntity>> registerUser(UserEntity user) async {
    try {
      final response = await _usersApiService.register(
        firstName: user.firstName!,
        lastName: user.lastName!,
        email: user.email!,
        phone: user.phone!,
        dob: user.dob!,
        roleId: user.roleId!,
        domainId: user.domainId!,
        password: user.password!,
        experience: user.experience!,
      );
      if (response.data['status'] == 200) {
        var body = response.data['body'];
        UserModel userModel = UserModel.fromJson(body[0]);
        return DataSuccess(userModel, response.data['user_msg']);
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
  Future<DataState<List<UserModel>>> getUsers() async {
    try {
      final response = await _usersApiService.getUsers();

      if (response.data['status'] == 200) {
        List<UserModel> result = [];
        for (var res in response.data["body"]) {
          result.add(UserModel.fromJson(res));
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
  Future<DataState<String>> deleteUsers(UserEntity user) async {
    try {
      final response = await _usersApiService.deleteUser(user.id!);

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
  Future<DataState<String>> updateUsers(UserEntity user) async {
    try {
      final response = await _usersApiService.updateUser(
          user.id!,
          user.firstName!,
          user.lastName!,
          user.email!,
          user.phone!,
          user.dob!,
          user.domainId!,
          user.roleId!,
          user.experience!,
          user.password!);

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
  Future<DataState<dynamic>> verifyToken(String tokenData) async {
    try {
      final response = await _usersApiService.verifyToken(tokenData);

      if (response.data['status'] == 200) {
        String message;
        message = response.data["user_msg"];
        Map<String, dynamic>? body = response.data["body"];
        dynamic data = [message, body];
        return DataSuccess(data, message);
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
  Future<DataState<UserEntity>> getSingleUser(int userId) async {
    try {
      final response = await _usersApiService.getSingleUser(userId);

      if (response.data['status'] == 200) {
        return DataSuccess(response.data['body'], response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            error: response.data['user_msg'],
            message: response.data['message'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
