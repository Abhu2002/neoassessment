// To parse this JSON data, do
//
//     final candidateEntity = candidateEntityFromJson(jsonString);

import 'dart:convert';

import 'package:neoassessment_flutter/domain/entities/candidates/candidate_entity.dart';

CandidateEntity candidateModelFromJson(String str) =>
    CandidateModel.fromJson(json.decode(str));

String candidateModelToJson(CandidateModel data) => json.encode(data.toJson());

class CandidateModel extends CandidateEntity {
  const CandidateModel({
    super.id,
    super.firstName,
    super.lastName,
    super.email,
    super.dob,
    super.domainId,
    super.experience,
    super.password,
    super.accessToken,
    super.phone,
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) => CandidateModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
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
}
