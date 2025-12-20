import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final DateTime? dob;
  final int? domainId;
  final int? roleId;
  final int? experience;
  final String? password;
  final String? accessToken;

  const UserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.dob,
    this.domainId,
    this.roleId,
    this.experience,
    this.password,
    this.accessToken,
  });

  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      lastName,
      email,
      phone,
      dob,
      domainId,
      roleId,
      experience,
      password,
      accessToken,
    ];
  }
}
