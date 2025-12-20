import 'package:equatable/equatable.dart';
import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';
import 'package:neoassessment_flutter/domain/entities/questionCat/questionCat_entity.dart';
import 'package:neoassessment_flutter/domain/entities/questions/questions_entity.dart';

import '../../../domain/entities/candidates/candidate_entity.dart';
import '../../../domain/entities/domains/domain_entity.dart';
import '../../../domain/entities/exams/exam_entity.dart';

abstract class RemoteExamState extends Equatable {
  const RemoteExamState();
}

class InitialState extends RemoteExamState {
  @override
  List<Object?> get props => [];
}

class DataLoadedState extends RemoteExamState {
  final List<DomainEntity> domains;
  final List<LevelEntity> levels;
  final List<QuestionEntity> questions;
  final List<QuestionCatEntity> questionCats;
  final List<ExamEntity> exam;

  const DataLoadedState({
    required this.domains,
    required this.levels,
    required this.questions,
    required this.questionCats,
    required this.exam,
  });

  @override
  List<Object?> get props => [
        domains,
        levels,
        questions,
      ];
}

class QuestionFilteredState extends RemoteExamState {
  final List<QuestionEntity> questions;
  final DateTime time;

  const QuestionFilteredState({
    required this.questions,
    required this.time,
  });

  @override
  List<Object?> get props => [questions, time];
}

class ExamFilteredState extends RemoteExamState {
  final List<ExamEntity> exams;
  final DateTime time;

  const ExamFilteredState({required this.exams, required this.time});

  @override
  List<Object?> get props => [exams, time];
}

class SelectedQuestionsState extends RemoteExamState {
  final List<QuestionEntity> selectedQuestions;
  final List<QuestionEntity> filteredQuestions;

  const SelectedQuestionsState(
      {required this.selectedQuestions, required this.filteredQuestions});

  @override
  List<Object?> get props => [selectedQuestions];
}

class SelectedExamsState extends RemoteExamState {
  final List<ExamEntity> selectedExams;
  final List<ExamEntity> filteredExams;

  const SelectedExamsState(
      {required this.selectedExams, required this.filteredExams});

  @override
  List<Object?> get props => [selectedExams];
}

class ExamErrorState extends RemoteExamState {
  final String message;
  final DateTime dateTime;

  const ExamErrorState(this.message, this.dateTime);

  @override
  List<Object?> get props => [message, dateTime];
}

class LoadCandidatesAndLevels extends RemoteExamState {
  final List<CandidateEntity> candidates;
  final List<LevelEntity> levels;
  final List<DomainEntity> domains;
  final List<ExamEntity> exams;

  const LoadCandidatesAndLevels({
    required this.candidates,
    required this.levels,
    required this.domains,
    required this.exams,
  });

  @override
  List<Object?> get props => [candidates, levels, exams, domains,];
}

class ExamAssignedState extends RemoteExamState {
  final String message;

  const ExamAssignedState({required this.message});
  @override
  List<Object?> get props => [message];

}

class ExamCreatedState extends RemoteExamState {
  final String message;

  const ExamCreatedState({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteExamDone extends RemoteExamState {
  final String message;

  const DeleteExamDone(this.message);

  @override
  List<Object> get props => [message];
}
