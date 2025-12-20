import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/domain/usecases/questionCat/get_questionCat.dart';
import 'package:neoassessment_flutter/presentation/bloc/questionCat/remote_questionCat_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/questionCat/remote_questionCat_state.dart';

import '../../../core/resources/data_state.dart';
import '../../../domain/entities/domains/domain_entity.dart';
import '../../../domain/entities/questionCat/questionCat_entity.dart';
import '../../../domain/usecases/domains/get_domains.dart';
import '../../../domain/usecases/questionCat/create_questionCat.dart';
import '../../../domain/usecases/questionCat/delete_questionCat.dart';
import '../../../domain/usecases/questionCat/update_questionCat.dart';

class QuestionCatBloc
    extends Bloc<RemoteQuestionCatEvent, RemoteQuestionCatState> {
  final GetQuestionCatUseCase _getQuestionCatUseCase;
  final DeleteQuestionCatUseCase _deleteQuestionCatUseCase;
  final CreateQuestionCatUseCase _createQuestionUseCase;
  final GetDomainsUseCase _getDomainsUseCase;
  final UpdateQuestionCatUseCase _updateQuestionCatUseCase;

  QuestionCatBloc(
      this._getQuestionCatUseCase,
      this._deleteQuestionCatUseCase,
      this._createQuestionUseCase,
      this._getDomainsUseCase,
      this._updateQuestionCatUseCase)
      : super(const RemoteQuestionCatLoading()) {
    on<GetQuestionCatEvent>(onGetQuestionCat);
    on<DeleteQuestionCatEvent>(onDeleteQuestionCat);
    on<CreateQuestionCatEvent>(onCreateQuestionCat);
    on<UpdateQuestionCatEvent>(onUpdateQuestionCat);
  }

  void onGetQuestionCat(
      GetQuestionCatEvent event, Emitter<RemoteQuestionCatState> emit) async {
    final dataState = await _getQuestionCatUseCase();
    final domainsState = await _getDomainsUseCase();

    List<DomainEntity> domains = [];
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      if (domainsState is DataSuccess) {
        domains = domainsState.data!;
      }

      emit(RemoteQuestionCatDone(dataState.data!, domains: domains));
    }

    if (dataState is DataFailed) {
      emit((RemoteQuestionCatError(dataState.error!.message!)));
    }
  }

  void onDeleteQuestionCat(DeleteQuestionCatEvent event,
      Emitter<RemoteQuestionCatState> emit) async {
    QuestionCatEntity questionCatEntity = QuestionCatEntity(id: event.id);
    final dataState =
        await _deleteQuestionCatUseCase(params: questionCatEntity);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(DeleteRemoteQuestionCatDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(RemoteQuestionCatError(dataState.error!.message!));
    }
  }

  void onCreateQuestionCat(CreateQuestionCatEvent event,
      Emitter<RemoteQuestionCatState> emit) async {
    QuestionCatEntity questionCatEntity = QuestionCatEntity(
        domainId: event.domainId,
        name: event.name,
        description: event.description);
    final dataState = await _createQuestionUseCase(params: questionCatEntity);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(QuestionCatCreatedState(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(RemoteQuestionCatError(dataState.error!.message!));
    }
  }

  void onUpdateQuestionCat(UpdateQuestionCatEvent event,
      Emitter<RemoteQuestionCatState> emit) async {
    QuestionCatEntity questionCatEntity = QuestionCatEntity(
        id: event.id,
        domainId: event.domainId,
        name: event.name,
        description: event.description);
    final dataState =
        await _updateQuestionCatUseCase(params: questionCatEntity);

    if (dataState is DataSuccess) {
      emit(QuestionCatUpdatedState(dataState.message!));
    } else {
      emit(RemoteQuestionCatError(dataState.error!.message!));
    }
  }
}
