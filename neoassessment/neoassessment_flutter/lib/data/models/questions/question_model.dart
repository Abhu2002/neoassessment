import 'package:neoassessment_flutter/domain/entities/questions/questions_entity.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel({
    super.id,
    super.domainId,
    super.levelId,
    super.question,
    super.questionCategoryId,
    super.op1,
    super.op2,
    super.op3,
    super.op4,
    super.correctOp,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        domainId: json["domain_id"],
        levelId: json["level_id"],
        question: json["question"],
        questionCategoryId: json["question_category_id"],
        op1: json["op1"],
        op2: json["op2"],
        op3: json["op3"],
        op4: json["op4"],
        correctOp: json["correct_op"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "domain_id": domainId,
        "level_id": levelId,
        "question": question,
        "question_category_id": questionCategoryId,
        "op1": op1,
        "op2": op2,
        "op3": op3,
        "op4": op4,
        "correct_op": correctOp,
      };
}
