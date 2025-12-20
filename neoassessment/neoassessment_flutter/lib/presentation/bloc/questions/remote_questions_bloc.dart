import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/utils/sharedPref.dart';
import 'package:neoassessment_flutter/domain/entities/questions/questions_entity.dart';
import 'package:neoassessment_flutter/domain/usecases/questionCat/get_questionCat.dart';
import 'package:neoassessment_flutter/domain/usecases/questions/create_question.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_state.dart';

import '../../../domain/usecases/domains/get_domains.dart';
import '../../../domain/usecases/level/get_levels.dart';
import '../../../domain/usecases/questions/delete_question.dart';
import '../../../domain/usecases/questions/get_questions.dart';
import '../../../domain/usecases/questions/update_question.dart';

class RemoteQuestionBloc
    extends Bloc<RemoteQuestionsEvent, RemoteQuestionsState> {
  final GetQuestionsUseCase _getQuestionsUseCase;
  final GetDomainsUseCase _getDomainsUseCase;
  final GetLevelsUseCase _getLevelsUseCase;
  final GetQuestionCatUseCase _getQuestionCatUseCase;
  final DeleteQuestionUseCase _deleteQuestionUseCase;
  final CreateQuestionUseCase _createQuestionUseCase;
  final UpdateQuestionUseCase _updateQuestionUseCase;

  RemoteQuestionBloc(
      this._getQuestionsUseCase,
      this._getDomainsUseCase,
      this._getLevelsUseCase,
      this._getQuestionCatUseCase,
      this._deleteQuestionUseCase,
      this._createQuestionUseCase,
      this._updateQuestionUseCase)
      : super(InitialQuestionsState()) {
    on<InitialQuestionsEvent>(onInitialQuestionsEvent);
    on<GetQuestionsEvent>(onGetQuestionsEvent);
    on<DeleteQuestionEvent>(onDeleteQuestionEvent);
    on<CreateQuestionEvent>(onCreateQuestionEvent);
    on<UpdateQuestionEvent>(onUpdateQuestionEvent);
  }

  void onInitialQuestionsEvent(
      InitialQuestionsEvent event, Emitter<RemoteQuestionsState> emit) {
    emit(InitialQuestionsState());
  }

  void onGetQuestionsEvent(
      GetQuestionsEvent event, Emitter<RemoteQuestionsState> emit) async {
    var domains = await _getDomainsUseCase();
    final questionsDataState = await _getQuestionsUseCase();
    final levelsDataState = await _getLevelsUseCase();
    final questionCatDataState = await _getQuestionCatUseCase();

    if (domains != null) {
      emit(
        LoadQuestionsState(
          questionsDataState.data,
          domains.data,
          levelsDataState.data,
          questionCatDataState.data,
        ),
      );
      await Prefs.deleteDomains();
      return;
    }

    final domainsDataState = await _getDomainsUseCase();
    if (questionsDataState is DataSuccess) {
      emit(LoadQuestionsState(
        questionsDataState.data,
        domainsDataState.data,
        levelsDataState.data,
        questionCatDataState.data,
      ));
    } else {
      emit(QuestionErrorState(questionsDataState.message!, DateTime.now()));
    }
  }

  void onCreateQuestionEvent(
      CreateQuestionEvent event, Emitter<RemoteQuestionsState> emit) async {
    QuestionEntity questionEntity = QuestionEntity(
      domainId: event.domainId,
      levelId: event.levelId,
      questionCategoryId: event.categoryId,
      question: event.question,
      op1: event.op1,
      op2: event.op2,
      op3: event.op3,
      op4: event.op4,
      correctOp: event.correctOp,
    );
    final dataState = await _createQuestionUseCase(params: questionEntity);

    if (dataState is DataSuccess) {
      emit(QuestionCreatedState(dataState.data!));
    } else {
      var time = DateTime.now();
      emit(QuestionErrorState(dataState.error.toString(), time));
    }
  }

  void onUpdateQuestionEvent(
      UpdateQuestionEvent event, Emitter<RemoteQuestionsState> emit) async {
    QuestionEntity questionEntity = QuestionEntity(
      id: event.id,
      domainId: event.domainId,
      levelId: event.levelId,
      questionCategoryId: event.categoryId,
      question: event.question,
      op1: event.op1,
      op2: event.op2,
      op3: event.op3,
      op4: event.op4,
      correctOp: event.correctOp,
    );
    final dataState = await _updateQuestionUseCase(params: questionEntity);

    if (dataState is DataSuccess) {
      emit(QuestionUpdatedState(dataState.data!));
    } else {
      var time = DateTime.now();
      emit(QuestionErrorState(dataState.error.toString(), time));
    }
  }

  void onDeleteQuestionEvent(
      DeleteQuestionEvent event, Emitter<RemoteQuestionsState> emit) async {
    QuestionEntity questionEntity = QuestionEntity(id: event.id);
    final dataState = await _deleteQuestionUseCase(params: questionEntity);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(DeleteQuestionDone(dataState.data!));
    } else {
      var time = DateTime.now();
      emit(QuestionErrorState(dataState.error.toString(), time));
    }
  }
}
