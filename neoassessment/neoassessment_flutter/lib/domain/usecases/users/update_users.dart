import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';

import '../../entities/users/user_entity.dart';
import '../../repositories/users/users_repository.dart';

class UpdateUsersUseCase extends UseCase<DataState<dynamic>, UserEntity> {
  final UsersRepository _userRepository;

  UpdateUsersUseCase(this._userRepository);

  @override
  Future<DataState<dynamic>> call({UserEntity? params}) {
    final result = _userRepository.updateUsers(params!);
    return result;
  }
}
