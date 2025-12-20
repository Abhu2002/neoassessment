import 'package:equatable/equatable.dart';

abstract class RemoteCandidatesEvent extends Equatable {
  const RemoteCandidatesEvent();
}

class InitialCandidateEvent extends RemoteCandidatesEvent {
  @override
  List<Object?> get props => [];
}

class LoginCandidateEvent extends RemoteCandidatesEvent {
  final String email;
  final String password;

  const LoginCandidateEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class GetCandidatesEvent extends RemoteCandidatesEvent {
  const GetCandidatesEvent();

  @override
  List<Object?> get props => [];
}

class ChangeDomainEvent extends RemoteCandidatesEvent {
  final String newDomain;
  final int domainId;

  const ChangeDomainEvent(this.newDomain, this.domainId);

  @override
  List<Object?> get props => [newDomain, domainId];
}

class ChangeRoleEvent extends RemoteCandidatesEvent {
  final String newRole;
  final int newRoleId;

  const ChangeRoleEvent(this.newRole, this.newRoleId);

  @override
  List<Object> get props => [newRole, newRoleId];
}

class CreateCandidateEvent extends RemoteCandidatesEvent {
  final String firstname;
  final String lastName;
  final String emailId;
  final String phone;
  final int exp;
  final DateTime dob;
  final int domainId;
  final String password;

  const CreateCandidateEvent(this.firstname, this.lastName, this.emailId,
      this.phone, this.exp, this.dob, this.domainId, this.password);

  @override
  List<Object?> get props =>
      [firstname, lastName, emailId, phone, exp, dob, domainId, password];
}

class DeleteCandidateEvent extends RemoteCandidatesEvent {
  final int id;

  const DeleteCandidateEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateCandidateEvent extends RemoteCandidatesEvent {
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

  const UpdateCandidateEvent(
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

class VerifyTokenEvent extends RemoteCandidatesEvent {
  final String token;

  const VerifyTokenEvent(this.token);

  @override
  List<Object?> get props => [token];
}
