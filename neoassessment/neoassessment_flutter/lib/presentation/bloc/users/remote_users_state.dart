import 'package:equatable/equatable.dart';
import 'package:neoassessment_flutter/domain/entities/users/user_entity.dart';

import '../../../domain/entities/candidates/candidate_entity.dart';
import '../../../domain/entities/domains/domain_entity.dart';
import '../../../domain/entities/roles/role_entity.dart';
import '../../pages/loginscreen.dart';


abstract class RemoteUsersState extends Equatable {

  const RemoteUsersState();
  get type => null;
}

class InitialUserState extends RemoteUsersState {
  @override
  List<Object?> get props => [];
}

class UserErrorState extends RemoteUsersState {
  final String error;
  final DateTime dateTime;

  const UserErrorState(this.error, this.dateTime);

  @override
  List<Object?> get props => [error, dateTime];
}

class LoginUserState extends RemoteUsersState {
  final UserEntity userEntity;
  final String message;

  const LoginUserState(this.userEntity, this.message);

  @override
  List<Object?> get props => [userEntity, message];
}

class LoadUsersState extends RemoteUsersState {
  final List<UserEntity> allUsers;
  final List<DomainEntity>? domains;
  final List<RoleEntity>? roles;

  const LoadUsersState(this.allUsers, {this.domains, this.roles});

  @override
  List<Object?> get props => [allUsers, domains, roles];
}

class DomainChangedState extends RemoteUsersState {
  final String newDomain;
  final int domainId;

  const DomainChangedState(this.newDomain, this.domainId);

  @override
  List<Object?> get props => [newDomain];
}

class RoleChangedState extends RemoteUsersState {
  final String newRole;
  final int newRoleId;

  const RoleChangedState(this.newRole, this.newRoleId);

  @override
  List<Object?> get props => [newRole, newRoleId];
}

class CreateRemoteUserDone extends RemoteUsersState {
  final String message;

  const CreateRemoteUserDone(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteRemoteUsersDone extends RemoteUsersState {
  final String message;

  const DeleteRemoteUsersDone(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateUsersDone extends RemoteUsersState {
  final String message;

  const UpdateUsersDone(this.message);

  @override
  List<Object> get props => [message];
}

class VerifyTokenDone extends RemoteUsersState {
  final dynamic data;
  final DateTime datetime;

  const VerifyTokenDone(this.data, this.datetime);

  @override
  List<Object> get props => [data, datetime];
}

class UserTypeState extends RemoteUsersState {
  final UserType type;

  const UserTypeState(this.type);

  @override
  // TODO: implement props
  List<Object?> get props => [type];


}
  class LoginUserCandidateState extends RemoteUsersState {
  final CandidateEntity userEntity;
  final String message;

  const LoginUserCandidateState(this.userEntity, this.message);

  @override
  List<Object?> get props => [userEntity, message];
}

class CandidateUserErrorState extends RemoteUsersState  {
  final String error;
  final DateTime dateTime;

  const CandidateUserErrorState(this.error, this.dateTime);

  @override
  List<Object?> get props => [error, dateTime];
}
