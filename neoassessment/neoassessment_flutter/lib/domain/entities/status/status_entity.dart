// To parse this JSON data, do
//
//     final statusEntity = statusEntityFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

StatusEntity statusEntityFromJson(String str) => StatusEntity.fromJson(json.decode(str));

String statusEntityToJson(StatusEntity data) => json.encode(data.toJson());

class StatusEntity extends Equatable {
  final int? id;
  final String? status;

  const StatusEntity({
    this.id,
    this.status,
  });

  factory StatusEntity.fromJson(Map<String, dynamic> json) => StatusEntity(
    id: json["id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
  };

  @override
  List<Object?> get props => [id, status];
}
