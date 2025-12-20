// To parse this JSON data, do
//
//     final examEntity = examEntityFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ExamEntity examEntityFromJson(String str) =>
    ExamEntity.fromJson(json.decode(str));

String examEntityToJson(ExamEntity data) => json.encode(data.toJson());

class ExamEntity extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final int? domainId;
  final int? noOfQuestions;
  final int? level;
  final List<int>? questionIds;
  final int? passingScore;

  const ExamEntity({
    this.id,
    this.name,
    this.description,
    this.domainId,
    this.noOfQuestions,
    this.level,
    this.questionIds,
    this.passingScore,
  });

  factory ExamEntity.fromJson(Map<String, dynamic> json) => ExamEntity(
        name: json["name"],
        description: json["description"],
        domainId: json["domain_id"],
        noOfQuestions: json["no_of_questions"],
        level: json["level"],
        questionIds: json["question_ids"] == null
            ? []
            : List<int>.from(json["question_ids"]!.map((x) => x)),
        passingScore: json["passing_score"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "domain_id": domainId,
        "no_of_questions": noOfQuestions,
        "level": level,
        "question_ids": questionIds == null
            ? []
            : List<dynamic>.from(questionIds!.map((x) => x)),
        "passing_score": passingScore,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        domainId,
        noOfQuestions,
        level,
        questionIds,
        passingScore,
      ];
}
