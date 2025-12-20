import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/roles/role_entity.dart';

abstract class RolesRepository {
  Future<DataState<List<RoleEntity>>> getRoles();

  Future<DataState<String>> createRole(RoleEntity role);

  Future<DataState<String>> deleteRoles(RoleEntity role);

  Future<DataState<String>> updateRoles(RoleEntity role);
}
