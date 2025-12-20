import 'package:equatable/equatable.dart';

abstract class RemoteQuestionsEvent extends Equatable {
  const RemoteQuestionsEvent();
}

class InitialQuestionsEvent extends RemoteQuestionsEvent {
  @override
  List<Object?> get props => [];
}

class GetQuestionsEvent extends RemoteQuestionsEvent {
  const GetQuestionsEvent();

  @override
  List<Object?> get props => [];
}

class CreateQuestionEvent extends RemoteQuestionsEvent {
  final String question;
  final String op1;
  final String op2;
  final String op3;
  final String op4;
  final String correctOp;
  final int domainId;
  final int levelId;
  final int categoryId;

  const CreateQuestionEvent({
    required this.question,
    required this.op1,
    required this.op2,
    required this.op3,
    required this.op4,
    required this.correctOp,
    required this.domainId,
    required this.levelId,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [
        question,
        op1,
        op2,
        op3,
        op4,
        correctOp,
        domainId,
        levelId,
        categoryId,
      ];
}

class UpdateQuestionEvent extends RemoteQuestionsEvent {
  final int id;
  final String question;
  final String op1;
  final String op2;
  final String op3;
  final String op4;
  final String correctOp;
  final int domainId;
  final int levelId;
  final int categoryId;

  const UpdateQuestionEvent({
    required this.id,
    required this.question,
    required this.op1,
    required this.op2,
    required this.op3,
    required this.op4,
    required this.correctOp,
    required this.domainId,
    required this.levelId,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [
        id,
        question,
        op1,
        op2,
        op3,
        op4,
        correctOp,
        domainId,
        levelId,
        categoryId,
      ];
}

class DeleteQuestionEvent extends RemoteQuestionsEvent {
  final int id;

  const DeleteQuestionEvent(this.id);

  @override
  List<Object?> get props => [id];
}
