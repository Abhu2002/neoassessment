import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/response/response_entity.dart';
import 'package:neoassessment_flutter/domain/usecases/candidates/get_candidates.dart';
import 'package:neoassessment_flutter/domain/usecases/exams/get_examList.dart';
import 'package:neoassessment_flutter/domain/usecases/responses/update_response.dart';
import 'package:neoassessment_flutter/domain/usecases/users/get_users.dart';
import 'package:neoassessment_flutter/presentation/bloc/responses/remote_response_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/responses/remote_response_state.dart';

import '../../../domain/usecases/responses/delete_response.dart';
import '../../../domain/usecases/responses/get_responses.dart';
import '../../../domain/usecases/status/get_status.dart';

class RemoteResponseBloc
    extends Bloc<RemoteResponseEvent, RemoteResponseState> {
  final GetResponsesUseCase _getResponsesUseCase;
  final GetUsersUseCase _getUsersUseCase;
  final GetCandidatesUseCase _getCandidatesUseCase;
  final GetExamListUseCase _getExamsUseCase;
  final UpdateResponseUseCase _updateResponseUseCase;
  final DeleteResponseUseCase _deleteResponseUseCase;
  final GetStatusUseCase _getStatusUseCase;

  RemoteResponseBloc(
    this._getResponsesUseCase,
    this._getUsersUseCase,
    this._getCandidatesUseCase,
    this._getExamsUseCase,
    this._updateResponseUseCase,
    this._deleteResponseUseCase,
    this._getStatusUseCase,
  ) : super(const InitialResponseState()) {
    on<GetResponsesEvent>(onGetResponsesEvent);
    on<UpdateResponseEvent>(onUpdateResponseEvent);
    on<DeleteResponseEvent>(onDeleteResponseEvent);
  }

  void onGetResponsesEvent(
      GetResponsesEvent event, Emitter<RemoteResponseState> emit) async {
    final responsesDataState = await _getResponsesUseCase();
    final usersDataState = await _getUsersUseCase();
    final candidatesDataState = await _getCandidatesUseCase();
    final examDataState = await _getExamsUseCase();
    final statusDataState = await _getStatusUseCase();

    if (responsesDataState is DataFailed) {
      emit(
        ResponseErrorState(
          message: responsesDataState.error!.message!,
          time: DateTime.now(),
        ),
      );
    }
    if (usersDataState is DataFailed) {
      emit(
        ResponseErrorState(
          message: usersDataState.error!.message!,
          time: DateTime.now(),
        ),
      );
    }
    if (candidatesDataState is DataFailed) {
      emit(
        ResponseErrorState(
          message: candidatesDataState.error!.message!,
          time: DateTime.now(),
        ),
      );
    }
    if (examDataState is DataFailed) {
      emit(
        ResponseErrorState(
          message: examDataState.error!.message!,
          time: DateTime.now(),
        ),
      );
    }
    if (statusDataState is DataFailed) {
      emit(
        ResponseErrorState(
          message: statusDataState.error!.message!,
          time: DateTime.now(),
        ),
      );
    } else {
      emit(AllResponsesState(
        responses: responsesDataState.data,
        users: usersDataState.data,
        candidates: candidatesDataState.data,
        exams: examDataState.data,
        status: statusDataState.data,
      ));
    }
  }

  void onUpdateResponseEvent(
      UpdateResponseEvent event, Emitter<RemoteResponseState> emit) async {
    final dataState = await _updateResponseUseCase(
      params: event.responseEntity,
    );
    if (dataState is DataSuccess) {
      emit(
        ResponseUpdatedState(message: dataState.data, time: DateTime.now()),
      );
    } else {
      emit(ResponseErrorState(
          message: dataState.error!.message!, time: DateTime.now()));
    }
  }

  void onDeleteResponseEvent(
      DeleteResponseEvent event, Emitter<RemoteResponseState> emit) async {
    ResponseEntity responseEntity = ResponseEntity(
      id: event.responseId,
    );
    final dataState = await _deleteResponseUseCase(params: responseEntity);

    if (dataState is DataSuccess) {
      emit(ResponseDeletedState(
          message: dataState.message!, time: DateTime.now()));
    } else {
      emit(ResponseErrorState(
          message: dataState.error!.message!, time: DateTime.now()));
    }
  }
}
