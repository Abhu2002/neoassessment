import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/repositories/users/users_repository.dart';

class GetUsersUseCase implements UseCase<DataState<dynamic>, void> {
  final UsersRepository _usersRepository;

  GetUsersUseCase(this._usersRepository);

  @override
  Future<DataState<dynamic>> call({void params}) {
    final result = _usersRepository.getUsers();
    return result;
  }
}
