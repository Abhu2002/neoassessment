import 'package:neoassessment_flutter/domain/entities/status/status_entity.dart';

class StatusModel extends StatusEntity {
  const StatusModel({super.id, super.status});

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
    id: json["id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
  };
}