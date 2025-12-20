import 'package:neoassessment_flutter/domain/entities/roles/role_entity.dart';

class RoleModel extends RoleEntity {
  const RoleModel({required super.id, required super.name});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
