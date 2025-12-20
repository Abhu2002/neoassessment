import 'package:neoassessment_flutter/domain/entities/response/response_entity.dart';

class ResponseModel extends ResponseEntity {
  const ResponseModel({
    super.id,
    super.candidateId,
    super.reviewedBy,
    super.assignBy,
    super.examId,
    super.qIds,
    super.response,
    super.score,
    super.statusId,
  });
  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    id: json["id"],
    candidateId: json["candidate_id"],
    examId: json["exam_id"],
    score: json["score"],
    assignBy: json["assign_by"],
    reviewedBy: json["reviewed_by"],
    qIds: json["q_ids"] == null ? [] : List<int>.from(json["q_ids"]!.map((x) => x)),
    response: json["response"] == null ? [] : List<String>.from(json["response"]!.map((x) => x)),
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
    "response": response == null ? [] : List<dynamic>.from(response!.map((x) => x)),
    "status_id": statusId,
  };
}
