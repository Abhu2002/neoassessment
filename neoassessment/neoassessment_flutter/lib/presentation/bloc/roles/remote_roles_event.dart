import 'package:equatable/equatable.dart';

abstract class RemoteRolesEvent extends Equatable {
  const RemoteRolesEvent();
}

class GetRoles extends RemoteRolesEvent {
  const GetRoles();

  @override
  List<Object?> get props => [];
}

class CreateRoles extends RemoteRolesEvent {
  final String rolename;

  const CreateRoles(this.rolename);

  @override
  List<Object?> get props => [rolename];
}

class RoleNameNotAvailable extends RemoteRolesEvent {
  @override
  List<Object?> get props => [];
}

class DeleteRoles extends RemoteRolesEvent {
  final int roleId;

  const DeleteRoles(this.roleId);

  @override
  List<Object?> get props => [roleId];
}

class UpdateRoles extends RemoteRolesEvent {
  final int roleId;
  final String newRoleName;

  const UpdateRoles(this.roleId, this.newRoleName);

  @override
  List<Object?> get props => [roleId, newRoleName];
}
