import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/roles/role_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/roles/roles_repository.dart';

import '../../../core/usecases/usecase.dart';

class DeleteRoleUsecase implements UseCase<DataState<dynamic>, RoleEntity> {
  final RolesRepository _rolesRepository;

  DeleteRoleUsecase(this._rolesRepository);

  @override
  Future<DataState<dynamic>> call({RoleEntity? params}) {
    final result = _rolesRepository.deleteRoles(params!);
    return result;
  }
}
