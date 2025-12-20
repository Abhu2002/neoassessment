import 'package:neoassessment_flutter/domain/entities/users/user_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class UsersRepository {
  Future<DataState<UserEntity>> loginUser(UserEntity user);

  Future<DataState<UserEntity>> registerUser(UserEntity user);

  Future<DataState<List<UserEntity>>> getUsers();

  Future<DataState<String>> deleteUsers(UserEntity user);

  Future<DataState<String>> updateUsers(UserEntity user);

  Future<DataState<UserEntity>> getSingleUser(int userId);

  Future<DataState<dynamic>> verifyToken(String tokenData);
}
