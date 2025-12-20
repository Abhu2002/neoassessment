import 'package:equatable/equatable.dart';

import '../../../domain/entities/candidates/candidate_entity.dart';
import '../../../domain/entities/domains/domain_entity.dart';
import '../../../domain/entities/roles/role_entity.dart';

abstract class RemoteCandidatesState extends Equatable {
  const RemoteCandidatesState();
}

class InitialCandidateState extends RemoteCandidatesState {
  @override
  List<Object?> get props => [];
}

class CandidateErrorState extends RemoteCandidatesState {
  final String error;
  final DateTime dateTime;

  const CandidateErrorState(this.error, this.dateTime);

  @override
  List<Object?> get props => [error, dateTime];
}

class LoginCandidateState extends RemoteCandidatesState {
  final CandidateEntity userEntity;
  final String message;

  const LoginCandidateState(this.userEntity, this.message);

  @override
  List<Object?> get props => [userEntity, message];
}

class LoadCandidatesState extends RemoteCandidatesState {
  final List<CandidateEntity> allCandidates;
  final List<DomainEntity>? domains;
  final List<RoleEntity>? roles;

  const LoadCandidatesState(this.allCandidates, {this.domains, this.roles});

  @override
  List<Object?> get props => [allCandidates, domains, roles];
}

class DomainChangedState extends RemoteCandidatesState {
  final String newDomain;
  final int domainId;

  const DomainChangedState(this.newDomain, this.domainId);

  @override
  List<Object?> get props => [newDomain];
}

class RoleChangedState extends RemoteCandidatesState {
  final String newRole;
  final int newRoleId;

  const RoleChangedState(this.newRole, this.newRoleId);

  @override
  List<Object?> get props => [newRole, newRoleId];
}

class CreateRemoteCandidateDone extends RemoteCandidatesState {
  final String message;

  const CreateRemoteCandidateDone(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteRemoteCandidatesDone extends RemoteCandidatesState {
  final String message;

  const DeleteRemoteCandidatesDone(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateCandidatesDone extends RemoteCandidatesState {
  final String message;

  const UpdateCandidatesDone(this.message);

  @override
  List<Object> get props => [message];
}

class VerifyTokenDone extends RemoteCandidatesState {
  final dynamic data;
  final DateTime datetime;

  const VerifyTokenDone(this.data, this.datetime);

  @override
  List<Object> get props => [data, datetime];
}
