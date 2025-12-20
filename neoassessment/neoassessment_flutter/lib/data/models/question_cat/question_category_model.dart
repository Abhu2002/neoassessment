// To parse this JSON data, do
//
//     final questionCatModel = questionCatModelFromJson(jsonString);

import 'dart:convert';

import 'package:neoassessment_flutter/domain/entities/questionCat/questionCat_entity.dart';

List<QuestionCatModel> questionCatModelFromJson(String str) =>
    List<QuestionCatModel>.from(
        json.decode(str).map((x) => QuestionCatModel.fromJson(x)));

String questionCatModelToJson(List<QuestionCatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionCatModel extends QuestionCatEntity {
  final int? id;
  final int? domainId;
  final String? name;
  final String? description;

  const QuestionCatModel({
    this.id,
    this.domainId,
    this.name,
    this.description,
  });

  factory QuestionCatModel.fromJson(Map<String, dynamic> json) =>
      QuestionCatModel(
        id: json["id"],
        domainId: json["domain_id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "domain_id": domainId,
        "name": name,
        "description": description,
      };
}
