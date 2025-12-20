import 'package:equatable/equatable.dart';

import '../../../domain/entities/roles/role_entity.dart';

abstract class RemoteRolesState extends Equatable {
  const RemoteRolesState();

  @override
  List<Object?> get props => [];
}

class RemoteRoleInitial extends RemoteRolesState {}

class RemoteRolesLoading extends RemoteRolesState {
  const RemoteRolesLoading();
}

class RemoteRolesDone extends RemoteRolesState {
  final List<RoleEntity> result;

  const RemoteRolesDone(this.result);

  @override
  List<Object> get props => [result];
}

class RoleNameNotAvailableState extends RemoteRolesState {}

class CreateRemoteRolesDone extends RemoteRolesState {
  final String message;

  const CreateRemoteRolesDone(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteRemoteRolesDone extends RemoteRolesState {
  final String message;

  const DeleteRemoteRolesDone(this.message);

  @override
  List<Object> get props => [message];
}

class RemoteRolesError extends RemoteRolesState {
  final String errormsg;

  const RemoteRolesError(this.errormsg);

  @override
  List<Object> get props => [errormsg];
}

class UpdateRolesDone extends RemoteRolesState {
  final String message;

  const UpdateRolesDone(this.message);

  @override
  List<Object> get props => [message];
}
