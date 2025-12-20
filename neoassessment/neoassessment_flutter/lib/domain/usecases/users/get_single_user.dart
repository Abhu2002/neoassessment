import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/repositories/users/users_repository.dart';

import '../../../core/resources/data_state.dart';

class GetSingleUserUseCase extends UseCase<DataState<dynamic>, int> {
  final UsersRepository _usersRepository;

  GetSingleUserUseCase(this._usersRepository);

  @override
  Future<DataState> call({int? params}) {
    final response = _usersRepository.getSingleUser(params!);
    return response;
  }

}