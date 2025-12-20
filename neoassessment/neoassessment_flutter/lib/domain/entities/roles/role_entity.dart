import 'dart:convert';

RoleEntity domainEntityFromJson(String str) =>
    RoleEntity.fromJson(json.decode(str));

String roleEntityToJson(RoleEntity data) => json.encode(data.toJson());

class RoleEntity {
  final int? id;
  final String? name;

  const RoleEntity({
    this.id,
    this.name,
  });

  /* @override
  List<Object?> get props {
    return [id, name];
  }*/
  factory RoleEntity.fromJson(Map<String, dynamic> json) => RoleEntity(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
