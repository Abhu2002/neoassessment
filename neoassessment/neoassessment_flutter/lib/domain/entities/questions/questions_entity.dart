import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final int? id;
  final int? domainId;
  final int? levelId;
  final String? question;
  final int? questionCategoryId;
  final String? op1;
  final String? op2;
  final String? op3;
  final String? op4;
  final String? correctOp;

  const QuestionEntity({
    this.id,
    this.domainId,
    this.levelId,
    this.question,
    this.questionCategoryId,
    this.op1,
    this.op2,
    this.op3,
    this.op4,
    this.correctOp,
  });

  @override
  List<Object?> get props => [
        id,
        domainId,
        levelId,
        question,
        questionCategoryId,
        op1,
        op2,
        op3,
        op4,
        correctOp,
      ];
}
