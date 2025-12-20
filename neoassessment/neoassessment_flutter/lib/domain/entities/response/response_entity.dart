// To parse this JSON data, do
//
//     final responseEntity = responseEntityFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ResponseEntity responseEntityFromJson(String str) =>
    ResponseEntity.fromJson(json.decode(str));

String responseEntityToJson(ResponseEntity data) => json.encode(data.toJson());

class ResponseEntity extends Equatable {
  final int? id;
  final int? candidateId;
  final int? examId;
  final dynamic score;
  final dynamic assignBy;
  final dynamic reviewedBy;
  final List<int>? qIds;
  final List<String>? response;
  final dynamic statusId;

  const ResponseEntity({
    this.id,
    this.candidateId,
    this.examId,
    this.score,
    this.assignBy,
    this.reviewedBy,
    this.qIds,
    this.response,
    this.statusId,
  });

  factory ResponseEntity.fromJson(Map<String, dynamic> json) => ResponseEntity(
        id: json["id"],
        candidateId: json["candidate_id"],
        examId: json["exam_id"],
        score: json["score"],
        assignBy: json["assign_by"],
        reviewedBy: json["reviewed_by"],
        qIds: json["q_ids"] == null
            ? []
            : List<int>.from(json["q_ids"]!.map((x) => x)),
        response: json["response"] == null
            ? []
            : List<String>.from(json["response"]!.map((x) => x)),
        statusId: json["status_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "candidate_id": candidateId,
        "exam_id": examId,
        "score": score,
        "assign_by": assignBy,
        "reviewed_by": reviewedBy,
        "q_ids": qIds == null ? [] : List<dynamic>.from(qIds!.map((x) => x)),
        "response":
            response == null ? [] : List<dynamic>.from(response!.map((x) => x)),
        "status_id": statusId,
      };

  @override
  List<Object?> get props => [
        id,
        candidateId,
        examId,
        reviewedBy,
        assignBy,
        qIds,
        response,
        statusId,
        score,
      ];
}
