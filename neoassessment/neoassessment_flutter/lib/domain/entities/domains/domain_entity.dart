import 'dart:convert';

DomainEntity domainEntityFromJson(String str) =>
    DomainEntity.fromJson(json.decode(str));

String domainEntityToJson(DomainEntity data) => json.encode(data.toJson());

class DomainEntity {
  final int? id;
  final String? name;
  final String? description;

  DomainEntity({
    this.id,
    this.name,
    this.description,
  });

  factory DomainEntity.fromJson(Map<String, dynamic> json) => DomainEntity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
