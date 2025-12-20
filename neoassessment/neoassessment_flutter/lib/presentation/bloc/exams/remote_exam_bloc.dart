import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/exams/exam_entity.dart';
import 'package:neoassessment_flutter/domain/entities/questions/questions_entity.dart';
import 'package:neoassessment_flutter/domain/entities/response/response_entity.dart';
import 'package:neoassessment_flutter/domain/usecases/level/get_levels.dart';
import 'package:neoassessment_flutter/domain/usecases/questions/get_questions.dart';
import 'package:neoassessment_flutter/presentation/bloc/exams/remote_exam_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/exams/remote_exam_state.dart';

import '../../../domain/usecases/candidates/get_candidates.dart';
import '../../../domain/usecases/domains/get_domains.dart';
import '../../../domain/usecases/exams/create_exam.dart';
import '../../../domain/usecases/exams/delete_exam.dart';
import '../../../domain/usecases/exams/get_examList.dart';
import '../../../domain/usecases/questionCat/get_questionCat.dart';
import '../../../domain/usecases/responses/save_response.dart';

class RemoteExamBloc extends Bloc<RemoteExamEvent, RemoteExamState> {
  final GetDomainsUseCase _getDomainsUseCase;
  final GetLevelsUseCase _getLevelsUseCase;
  final GetQuestionsUseCase _getQuestionsUseCase;
  final GetQuestionCatUseCase _getQuestionCatUseCase;
  final CreateExamUseCase _createExamUseCase;
  final GetExamListUseCase _getExamListUseCase;
  final DeleteExamUseCase _deleteExamUseCase;
  final GetCandidatesUseCase _getCandidatesUseCase;
  final SaveResponseUseCase _saveResponseUseCase;

  RemoteExamBloc(
    this._getDomainsUseCase,
    this._getLevelsUseCase,
    this._getQuestionsUseCase,
    this._getQuestionCatUseCase,
    this._createExamUseCase,
    this._getExamListUseCase,
    this._deleteExamUseCase,
    this._getCandidatesUseCase,
    this._saveResponseUseCase,
  ) : super(InitialState()) {
    on<LoadDataEvent>(onLoadDataEvent);
    on<FilterQuestionsEvent>(onFilterQuestionsEvent);
    on<SelectQuestionEvent>(onSelectQuestionEvent);
    on<CreateExamEvent>(onCreateExamEvent);
    on<GetExamListEvent>(onGetExamList);
    on<FilterExamEvent>(onFilterExamsEvent);
    on<SelectExamEvent>(onSelectExamEvent);
    on<DeleteExamEvent>(onDeleteExams);
    on<GetFilteredExamsEvent>(onGetFilteredExamsEvent);
    on<GetCandidatesAndLevels>(onGetCandidatesAndLevels);
    on<AssignExamEvent>(onAssignExamEvent);
  }

  void onLoadDataEvent(
      LoadDataEvent event, Emitter<RemoteExamState> emit) async {
    final domainsData = await _getDomainsUseCase();
    final levelsData = await _getLevelsUseCase();
    final questionsData = await _getQuestionsUseCase();
    final questionCatsData = await _getQuestionCatUseCase();

    if (domainsData is DataSuccess &&
        levelsData is DataSuccess &&
        questionsData is DataSuccess &&
        questionCatsData is DataSuccess) {
      emit(DataLoadedState(
        domains: domainsData.data,
        levels: levelsData.data,
        questions: questionsData.data,
        questionCats: questionCatsData.data,
        exam: const [],
      ));
    } else {
      if (domainsData is DataFailed) {
        emit(ExamErrorState(domainsData.error!.message!, DateTime.now()));
      } else if (levelsData is DataFailed) {
        emit(ExamErrorState(levelsData.error!.message!, DateTime.now()));
      } else if (questionsData is DataFailed) {
        emit(ExamErrorState(questionsData.error!.message!, DateTime.now()));
      } else {
        emit(ExamErrorState(questionCatsData.error!.message!, DateTime.now()));
      }
    }
  }

  void onFilterQuestionsEvent(
      FilterQuestionsEvent event, Emitter<RemoteExamState> emit) {
    List<QuestionEntity> filteredQuestions = [];
    List<QuestionEntity> questions = event.questions;

    for (var question in questions) {
      if (!filteredQuestions.contains(question)) {
        if (event.domainId == null || event.domainId != question.domainId) {
          continue;
        }
        if (event.levelId == null || event.levelId != question.levelId) {
          continue;
        }
        if (event.questionCategoryId == null ||
            event.questionCategoryId != question.questionCategoryId) {
          continue;
        }
        filteredQuestions.add(question);
      } else {
        continue;
      }
    }
    emit(QuestionFilteredState(
        questions: filteredQuestions, time: DateTime.now()));
  }

  void onSelectQuestionEvent(
      SelectQuestionEvent event, Emitter<RemoteExamState> emit) {
    List<QuestionEntity> selectedQuestions =
        event.allQuestions.where((question) {
      return event.selectedQuestions.contains(question.id);
    }).toList();
    emit(SelectedQuestionsState(
      selectedQuestions: selectedQuestions,
      filteredQuestions: event.filteredQuestions,
    ));
  }

  void onSelectExamEvent(SelectExamEvent event, Emitter<RemoteExamState> emit) {
    List<ExamEntity> selectedExams = event.allExams.where((exam) {
      return event.selectedExam.contains(exam.id);
    }).toList();
    emit(SelectedExamsState(
      selectedExams: selectedExams,
      filteredExams: event.filteredExam,
    ));
  }

  void onCreateExamEvent(
      CreateExamEvent event, Emitter<RemoteExamState> emit) async {
    ExamEntity examEntity = ExamEntity(
      name: event.examName,
      domainId: event.domainId,
      level: event.levelId,
      questionIds: event.questions,
      description: event.examDescription,
      noOfQuestions: event.questions.length,
      passingScore: event.passingScore,
    );
    final createExamDataState = await _createExamUseCase(params: examEntity);

    if (createExamDataState is DataSuccess) {
      emit(ExamCreatedState(message: createExamDataState.message!));
    } else {
      emit(ExamErrorState(createExamDataState.error!.message!, DateTime.now()));
    }
  }

  void onFilterExamsEvent(
      FilterExamEvent event, Emitter<RemoteExamState> emit) {
    List<ExamEntity> filteredExams = [];
    List<ExamEntity> exams = event.exams;
    for (var exam in exams) {
      if (!filteredExams.contains(exam)) {
        if (event.domainId == null || event.domainId != exam.domainId) {
          continue;
        }
        if (event.levelId == null || event.levelId != exam.level) {
          continue;
        }
        filteredExams.add(exam);
      } else {
        continue;
      }
    }
    emit(ExamFilteredState(exams: filteredExams, time: DateTime.now()));
  }

  void onGetExamList(
      GetExamListEvent event, Emitter<RemoteExamState> emit) async {
    final examlistDataState = await _getExamListUseCase();
    final levelsDataState = await _getLevelsUseCase();
    final questionsData = await _getQuestionsUseCase();
    final questionCatDataState = await _getQuestionCatUseCase();
    final domainsDataState = await _getDomainsUseCase();

    if (examlistDataState is DataSuccess) {
      emit(DataLoadedState(
          domains: domainsDataState.data,
          levels: levelsDataState.data,
          questions: questionsData.data,
          questionCats: questionCatDataState.data,
          exam: examlistDataState.data));
    } else {
      emit(ExamErrorState(examlistDataState.error!.message!, DateTime.now()));
    }
  }

  void onDeleteExams(
      DeleteExamEvent event, Emitter<RemoteExamState> emit) async {
    ExamEntity examEntity = ExamEntity(id: event.id);
    final dataState = await _deleteExamUseCase(params: examEntity);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(DeleteExamDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(ExamErrorState(dataState.error!.message!, DateTime.now()));
    }
  }

  void onGetCandidatesAndLevels(
      GetCandidatesAndLevels event, Emitter<RemoteExamState> emit) async {
    final candidateDataState = await _getCandidatesUseCase();
    final levelDataState = await _getLevelsUseCase();
    final domainDataState = await _getDomainsUseCase();
    final examDataState = await _getExamListUseCase();

    if (candidateDataState is DataFailed) {
      emit(ExamErrorState(candidateDataState.error!.message!, DateTime.now()));
    }
    if (levelDataState is DataFailed) {
      emit(ExamErrorState(levelDataState.error!.message!, DateTime.now()));
    }
    if (domainDataState is DataFailed) {
      emit(ExamErrorState(domainDataState.error!.message!, DateTime.now()));
    }
    if (examDataState is DataFailed) {
      emit(ExamErrorState(examDataState.error!.message!, DateTime.now()));
    } else {
      emit(
        LoadCandidatesAndLevels(
          candidates: candidateDataState.data,
          levels: levelDataState.data,
          domains: domainDataState.data,
          exams: examDataState.data,
        ),
      );
    }
  }

  void onGetFilteredExamsEvent(
      GetFilteredExamsEvent event, Emitter<RemoteExamState> emit) {
    List<ExamEntity> filteredExams = [];
    for (var exam in event.exams) {
      if (exam.domainId == event.domainId && exam.level == event.levelId) {
        filteredExams.add(exam);
      }
    }

    emit(
      ExamFilteredState(
        exams: filteredExams,
        time: DateTime.now(),
      ),
    );
  }

  void onAssignExamEvent(
      AssignExamEvent event, Emitter<RemoteExamState> emit) async {
    ResponseEntity responseEntity = ResponseEntity(
      examId: event.examId,
      candidateId: event.candidateId,
      assignBy: event.assignedBy,
    );
    final dataState = await _saveResponseUseCase(params: responseEntity);
    if (dataState is DataSuccess) {
      emit(ExamAssignedState(message: dataState.message!));
    } else {
      emit(
        ExamErrorState(
          dataState.error!.message!,
          DateTime.now(),
        ),
      );
    }
  }
}
