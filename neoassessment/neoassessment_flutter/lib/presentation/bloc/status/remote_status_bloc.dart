import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/presentation/bloc/status/remote_status_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/status/remote_status_state.dart';

import '../../../domain/entities/status/status_entity.dart';
import '../../../domain/usecases/status/create_status.dart';
import '../../../domain/usecases/status/delete_status.dart';
import '../../../domain/usecases/status/get_status.dart';
import '../../../domain/usecases/status/update_status.dart';



class RemoteStatusBloc extends Bloc<RemoteStatusEvent, RemoteStatusState> {
  final GetStatusUseCase _statusUseCase;
  final CreateStatusUseCase _createStatusUseCase;
  final UpdateStatusUseCase _updateStatusUseCase;
  final DeleteStatusUseCase _deleteStatusUseCase;

  RemoteStatusBloc(
      this._statusUseCase,
      this._createStatusUseCase,
      this._updateStatusUseCase,
      this._deleteStatusUseCase,
      ) : super(InitialStatusState()) {
    on<InitialStatusEvent>(onInitialStatusEvent);
    on<GetStatusEvent>(onGetStatusEvent);
    on<CreateStatusEvent>(onCreateStatusEvent);
    on<UpdateStatusEvent>(onUpdateStatusEvent);
    on<DeleteStatusEvent>(onDeleteStatusEvent);
  }

  void onInitialStatusEvent(
      InitialStatusEvent event, Emitter<RemoteStatusState> emit) {
    emit(InitialStatusState());
  }

  void onGetStatusEvent(
      GetStatusEvent event, Emitter<RemoteStatusState> emit) async {
    final dataState = await _statusUseCase();
    if (dataState is DataSuccess) {
      emit(LoadStatusState(dataState.data!));
    } else {
      emit(RemoteStatusError(dataState.error!.message!));
    }
  }

  void onCreateStatusEvent(
      CreateStatusEvent event, Emitter<RemoteStatusState> emit) async {
    StatusEntity statusEntity = StatusEntity(
      status: event.name,
    );
    final dataState = await _createStatusUseCase(params: statusEntity);

    if (dataState is DataSuccess) {
      emit(StatusCreatedState(dataState.message!));
    } else {
      emit(RemoteStatusError(dataState.error!.message!));
    }
  }

  void onUpdateStatusEvent(
      UpdateStatusEvent event, Emitter<RemoteStatusState> emit) async {
    StatusEntity statusEntity = StatusEntity(
      id: event.id,
      status: event.name,
    );
    final dataState = await _updateStatusUseCase(params: statusEntity);

    if (dataState is DataSuccess) {
      emit(StatusUpdatedState(dataState.message!));
    } else {
      emit(RemoteStatusError(dataState.error!.message!));
    }
  }

  void onDeleteStatusEvent(
      DeleteStatusEvent event, Emitter<RemoteStatusState> emit) async {
    final dataState = await _deleteStatusUseCase(params: StatusEntity(id: event.id));

    if (dataState is DataSuccess) {
      emit(StatusDeletedState(dataState.message!));
    } else {
      emit(RemoteStatusError(dataState.error!.message!));
    }
  }
}
