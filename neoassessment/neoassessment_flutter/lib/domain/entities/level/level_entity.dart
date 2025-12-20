import 'dart:convert';

LevelEntity levelEntityFromJson(String str) =>
    LevelEntity.fromJson(json.decode(str));

String levelEntityToJson(LevelEntity data) => json.encode(data.toJson());

class LevelEntity {
  final int? id;
  final int? number;

  LevelEntity({
    this.id,
    this.number,
  });

  factory LevelEntity.fromJson(Map<String, dynamic> json) => LevelEntity(
        id: json["id"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
      };
}
