import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/roles/role_entity.dart';

import '../../../core/usecases/usecase.dart';
import '../../repositories/roles/roles_repository.dart';

class CreateRoleUseCase implements UseCase<DataState<dynamic>, RoleEntity> {
  final RolesRepository _rolesRepository;

  CreateRoleUseCase(this._rolesRepository);

  @override
  Future<DataState<dynamic>> call({RoleEntity? params}) {
    final result = _rolesRepository.createRole(params!);
    return result;
  }
}
