import 'dart:convert';

import 'package:neoassessment_flutter/domain/entities/exams/exam_entity.dart';

ExamModel examModelFromJson(String str) => ExamModel.fromJson(json.decode(str));

String examModelToJson(ExamModel data) => json.encode(data.toJson());

class ExamModel extends ExamEntity {
  const ExamModel({
    super.id,
    super.name,
    super.description,
    super.domainId,
    super.noOfQuestions,
    super.level,
    super.questionIds,
    super.passingScore,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        id: json["id"],
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

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
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
}
