import 'dart:convert';

import 'package:equatable/equatable.dart';

CandidateEntity candidateEntityFromJson(String str) =>
    CandidateEntity.fromJson(json.decode(str));

String candidateEntityToJson(CandidateEntity data) =>
    json.encode(data.toJson());

class CandidateEntity extends Equatable {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final dynamic dob;
  final int? domainId;
  final int? experience;
  final String? password;
  final dynamic accessToken;
  final String? phone;

  const CandidateEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    this.domainId,
    this.experience,
    this.password,
    this.accessToken,
    this.phone,
  });

  factory CandidateEntity.fromJson(Map<String, dynamic> json) =>
      CandidateEntity(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        dob: json["dob"],
        domainId: json["domain_id"],
        experience: json["experience"],
        password: json["password"],
        accessToken: json["access_token"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "dob": dob,
        "domain_id": domainId,
        "experience": experience,
        "password": password,
        "access_token": accessToken,
        "phone": phone,
      };

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phone,
        dob,
        domainId,
        experience,
        password,
        accessToken
      ];
}
