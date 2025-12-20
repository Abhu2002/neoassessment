import 'package:equatable/equatable.dart';
import 'package:neoassessment_flutter/domain/entities/domains/domain_entity.dart';
import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';
import 'package:neoassessment_flutter/domain/entities/questionCat/questionCat_entity.dart';
import 'package:neoassessment_flutter/domain/entities/questions/questions_entity.dart';

abstract class RemoteQuestionsState extends Equatable {
  const RemoteQuestionsState();
}

class InitialQuestionsState extends RemoteQuestionsState {
  @override
  List<Object?> get props => [];
}

class QuestionErrorState extends RemoteQuestionsState {
  final String message;
  final DateTime dateTime;

  const QuestionErrorState(this.message, this.dateTime);

  @override
  List<Object?> get props => [message, dateTime];
}

class LoadQuestionsState extends RemoteQuestionsState {
  final List<QuestionEntity> allQuestions;
  final List<DomainEntity> allDomains;
  final List<LevelEntity> allLevels;
  final List<QuestionCatEntity> allCats;

  const LoadQuestionsState(
    this.allQuestions,
    this.allDomains,
    this.allLevels,
    this.allCats,
  );

  @override
  List<Object?> get props => [allQuestions];
}

class QuestionCreatedState extends RemoteQuestionsState {
  final String message;

  const QuestionCreatedState(this.message);

  @override
  List<Object?> get props => [message];
}

class QuestionUpdatedState extends RemoteQuestionsState {
  final String message;

  const QuestionUpdatedState(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteQuestionDone extends RemoteQuestionsState {
  final String message;

  const DeleteQuestionDone(this.message);

  @override
  List<Object?> get props => [message];
}
