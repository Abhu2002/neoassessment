import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/repositories/users/users_repository.dart';

class TokenUserUseCase extends UseCase<DataState<dynamic>, String> {
  final UsersRepository _usersRepository;

  TokenUserUseCase(this._usersRepository);

  @override
  Future<DataState<dynamic>> call({String? params}) {
    final result = _usersRepository.verifyToken(params!);
    return result;
  }
}
