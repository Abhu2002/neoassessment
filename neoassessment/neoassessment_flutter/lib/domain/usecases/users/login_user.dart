import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/entities/users/user_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/users/users_repository.dart';

class LoginUserUseCase extends UseCase<DataState<dynamic>, UserEntity> {
  final UsersRepository _usersRepository;

  LoginUserUseCase(this._usersRepository);

  @override
  Future<DataState<dynamic>> call({UserEntity? params}) {
    final result = _usersRepository.loginUser(params!);
    return result;
  }
}
