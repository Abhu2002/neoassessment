import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/users/user_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/users/users_repository.dart';

import '../../../core/usecases/usecase.dart';

class DeleteUserUseCase extends UseCase<DataState<dynamic>, UserEntity> {
  final UsersRepository _usersRepository;

  DeleteUserUseCase(this._usersRepository);

  @override
  Future<DataState<dynamic>> call({UserEntity? params}) {
    final result = _usersRepository.deleteUsers(params!);
    return result;
  }
}
