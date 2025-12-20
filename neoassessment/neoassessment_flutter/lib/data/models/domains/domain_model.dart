import 'package:neoassessment_flutter/domain/entities/domains/domain_entity.dart';

class DomainModel extends DomainEntity {
  DomainModel(
      {required super.id, required super.name, required super.description});

  factory DomainModel.fromJson(Map<String, dynamic> json) {
    return DomainModel(
        id: json["id"], name: json["name"], description: json["description"]);
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "description": description};
}
