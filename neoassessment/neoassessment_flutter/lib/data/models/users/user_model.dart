import 'package:neoassessment_flutter/domain/entities/users/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {super.id,
      super.firstName,
      super.lastName,
      super.email,
      super.phone,
      super.domainId,
      super.roleId,
      super.experience,
      super.password,
      super.dob,
      super.accessToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phone: json["phone"],
      dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
      domainId: json["domain_id"],
      roleId: json["role_id"],
      experience: json["experience"],
      password: json["password"],
      accessToken: json["access_token"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "dob": dob?.toIso8601String(),
        "domain_id": domainId,
        "role_id": roleId,
        "experience": experience,
        "password": password,
        "access_token": accessToken,
      };
}
