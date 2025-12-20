import 'package:equatable/equatable.dart';

import '../../pages/loginscreen.dart';

abstract class RemoteUsersEvent extends Equatable {
  const RemoteUsersEvent();
}

class InitialUserEvent extends RemoteUsersEvent {
  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends RemoteUsersEvent {
  final String email;
  final String password;

  const LoginUserEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class GetUsersEvent extends RemoteUsersEvent {
  const GetUsersEvent();

  @override
  List<Object?> get props => [];
}

class ChangeDomainEvent extends RemoteUsersEvent {
  final String newDomain;
  final int domainId;

  const ChangeDomainEvent(this.newDomain, this.domainId);

  @override
  List<Object?> get props => [newDomain, domainId];
}

class ChangeRoleEvent extends RemoteUsersEvent {
  final String newRole;
  final int newRoleId;

  const ChangeRoleEvent(this.newRole, this.newRoleId);

  @override
  List<Object> get props => [newRole, newRoleId];
}

class CreateUserEvent extends RemoteUsersEvent {
  final String firstname;
  final String lastName;
  final String emailId;
  final String phone;
  final int exp;
  final DateTime dob;
  final int domainId;
  final int roleId;
  final String password;

  const CreateUserEvent(this.firstname, this.lastName, this.emailId, this.phone,
      this.exp, this.dob, this.domainId, this.roleId, this.password);

  @override
  List<Object?> get props => [
        firstname,
        lastName,
        emailId,
        phone,
        exp,
        dob,
        domainId,
        roleId,
        password
      ];
}

class DeleteUserEvent extends RemoteUsersEvent {
  final int id;

  const DeleteUserEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateUserEvent extends RemoteUsersEvent {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime dob;
  final int domainId;
  final int roleId;
  final int exp;
  final String password;

  const UpdateUserEvent(
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.exp,
      this.dob,
      this.domainId,
      this.roleId,
      this.password);

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phone,
        dob,
        domainId,
        roleId,
        exp,
        password
      ];
}

class VerifyTokenEvent extends RemoteUsersEvent {
  final String token;

  const VerifyTokenEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class UserTypeEvent extends RemoteUsersEvent {
  final UserType type;
  const UserTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}


class LoginUserCandidateEvent extends RemoteUsersEvent {
  final String email;
  final String password;

  const LoginUserCandidateEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}