import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/entities/users/user_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/users/users_repository.dart';

class RegisterUserUseCase extends UseCase<DataState<dynamic>, UserEntity> {
  final UsersRepository _usersRepository;

  RegisterUserUseCase(this._usersRepository);

  @override
  Future<DataState<dynamic>> call({UserEntity? params}) {
    final result = _usersRepository.registerUser(params!);
    return result;
  }
}
