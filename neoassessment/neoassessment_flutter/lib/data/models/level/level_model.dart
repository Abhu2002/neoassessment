import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';

class LevelModel extends LevelEntity {
  LevelModel({required super.id, required super.number});

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json["id"],
      number: json["number"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
      };
}
