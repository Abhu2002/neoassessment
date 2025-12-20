import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/repositories/roles/roles_repository.dart';

class GetRolesUseCase implements UseCase<DataState<dynamic>, void> {
  final RolesRepository _rolesRepository;

  GetRolesUseCase(this._rolesRepository);

  @override
  Future<DataState<dynamic>> call({void params}) {
    final result = _rolesRepository.getRoles();
    return result;
  }
}
