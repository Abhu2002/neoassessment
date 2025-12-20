import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/roles/role_entity.dart';
import '../../repositories/roles/roles_repository.dart';

class UpdateRoleUsecase implements UseCase<DataState<dynamic>, RoleEntity> {
  final RolesRepository _rolesRepository;

  UpdateRoleUsecase(this._rolesRepository);

  @override
  Future<DataState<dynamic>> call({RoleEntity? params}) {
    final result = _rolesRepository.updateRoles(params!);
    return result;
  }
}
