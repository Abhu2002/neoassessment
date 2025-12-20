import 'package:equatable/equatable.dart';

import '../../../domain/entities/exams/exam_entity.dart';
import '../../../domain/entities/questions/questions_entity.dart';

abstract class RemoteExamEvent extends Equatable {
  const RemoteExamEvent();
}

class LoadDataEvent extends RemoteExamEvent {
  @override
  List<Object?> get props => [];
}

class FilterQuestionsEvent extends RemoteExamEvent {
  final int? questionCategoryId;
  final List<QuestionEntity> questions;
  final int? domainId;
  final int? levelId;

  const FilterQuestionsEvent({
    this.questionCategoryId,
    required this.questions,
    this.domainId,
    this.levelId,
  });

  @override
  List<Object?> get props => [questions, questionCategoryId, domainId, levelId];
}

class FilterExamEvent extends RemoteExamEvent {
  final int? domainId;
  final int? levelId;
  final List<ExamEntity> exams;
  final int? questionCategoryId;

  const FilterExamEvent(
      {this.domainId,
      required this.exams,
      this.questionCategoryId,
      this.levelId});

  @override
  List<Object?> get props => [exams, questionCategoryId, domainId, levelId];
}

class SelectQuestionEvent extends RemoteExamEvent {
  final List<int> selectedQuestions;
  final List<QuestionEntity> allQuestions;
  final List<QuestionEntity> filteredQuestions;

  const SelectQuestionEvent(
      {required this.selectedQuestions,
      required this.allQuestions,
      required this.filteredQuestions});

  @override
  List<Object?> get props => [selectedQuestions];
}

class SelectExamEvent extends RemoteExamEvent {
  final List<int> selectedExam;
  final List<ExamEntity> allExams;
  final List<ExamEntity> filteredExam;

  const SelectExamEvent(
      {required this.selectedExam,
      required this.allExams,
      required this.filteredExam});

  @override
  List<Object?> get props => [selectedExam];
}

class CreateExamEvent extends RemoteExamEvent {
  final List<int> questions;
  final int domainId;
  final int levelId;
  final int questionCatId;
  final String examName;
  final String examDescription;
  final int passingScore;

  const CreateExamEvent({
    required this.questions,
    required this.domainId,
    required this.levelId,
    required this.questionCatId,
    required this.examName,
    required this.examDescription,
    required this.passingScore,
  });

  @override
  List<Object?> get props => [
        questions,
        domainId,
        levelId,
        questionCatId,
        examName,
        examDescription,
        passingScore,
      ];
}

class GetExamListEvent extends RemoteExamEvent {
  const GetExamListEvent();

  @override
  List<Object?> get props => [];
}

class GetFilteredExamsEvent extends RemoteExamEvent {
  final int domainId;
  final int levelId;
  final List<ExamEntity> exams;

  const GetFilteredExamsEvent({
    required this.domainId,
    required this.levelId,
    required this.exams,
  });

  @override
  List<Object?> get props => [
        domainId,
        levelId,
      ];
}

class GetCandidatesAndLevels extends RemoteExamEvent {
  const GetCandidatesAndLevels();

  @override
  List<Object?> get props => [];
}

class AssignExamEvent extends RemoteExamEvent {
  final int examId;
  final int candidateId;
  final int assignedBy;

  const AssignExamEvent(
      {required this.examId,
      required this.candidateId,
      required this.assignedBy});

  @override
  List<Object?> get props => [
        examId,
        candidateId,
        assignedBy,
      ];
}

class DeleteExamEvent extends RemoteExamEvent {
  final int id;

  const DeleteExamEvent(this.id);

  @override
  List<Object?> get props => [id];
}
