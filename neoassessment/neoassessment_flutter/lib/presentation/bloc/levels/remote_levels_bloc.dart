import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';
import 'package:neoassessment_flutter/domain/usecases/level/get_levels.dart';
import 'package:neoassessment_flutter/domain/usecases/level/updateLevels.dart';
import 'package:neoassessment_flutter/presentation/bloc/levels/remote_levels_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/levels/remote_levels_state.dart';

import '../../../core/resources/data_state.dart';
import '../../../domain/usecases/level/create_levels.dart';
import '../../../domain/usecases/level/delete_levels.dart';

class RemoteLevelsBloc extends Bloc<RemoteLevelsEvent, RemoteLevelsState> {
  final GetLevelsUseCase _getLevelsUseCase;
  final CreateLevelUseCase _createLevelUsecase;
  final DeleteLevelsUseCase _deleteLevelUsecase;
  final UpdateLevelsUseCase _updateLevelUsecase;

  RemoteLevelsBloc(this._getLevelsUseCase, this._createLevelUsecase,
      this._deleteLevelUsecase, this._updateLevelUsecase)
      : super(const RemoteLevelLoading()) {
    on<GetLevelEvent>(onGetLevels);
    on<CreateLevelEvent>(onCreateLevels);
    on<DeleteLevelEvent>(onDeleteLevels);
    on<UpdateLevelEvent>(onUpdateLevels);
  }

  void onGetLevels(GetLevelEvent event, Emitter<RemoteLevelsState> emit) async {
    final dataState = await _getLevelsUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteLevelsDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteLevelsError(dataState.error!.message!));
    }
  }

  void onCreateLevels(
      CreateLevelEvent event, Emitter<RemoteLevelsState> emit) async {
    LevelEntity levelEntity = LevelEntity(number: event.number);
    final dataState = await _createLevelUsecase(params: levelEntity);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(CreateRemoteLevelsDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(RemoteLevelsError(dataState.error!.message!));
    }
  }

  void onDeleteLevels(
      DeleteLevelEvent event, Emitter<RemoteLevelsState> emit) async {
    LevelEntity levelEntity = LevelEntity(id: event.id);
    final dataState = await _deleteLevelUsecase(params: levelEntity);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(DeleteRemoteLevelsDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(RemoteLevelsError(dataState.error!.message!));
    }
  }

  void onUpdateLevels(
      UpdateLevelEvent event, Emitter<RemoteLevelsState> emit) async {
    LevelEntity levelEntity = LevelEntity(id: event.id, number: event.level);
    final dataState = await _updateLevelUsecase(params: levelEntity);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(UpdateLevelsDone(dataState.data));
    }
    if (dataState is DataFailed) {
      emit(RemoteLevelsError(dataState.error!.message!));
    }
  }
}
