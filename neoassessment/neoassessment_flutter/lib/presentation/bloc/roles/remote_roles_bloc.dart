import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/domain/entities/roles/role_entity.dart';
import 'package:neoassessment_flutter/domain/usecases/roles/create_roles.dart';
import 'package:neoassessment_flutter/domain/usecases/roles/delete_roles.dart';
import 'package:neoassessment_flutter/domain/usecases/roles/get_roles.dart';
import 'package:neoassessment_flutter/domain/usecases/roles/update_roles.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_state.dart';

import '../../../core/resources/data_state.dart';

class RemoteRolesBloc extends Bloc<RemoteRolesEvent, RemoteRolesState> {
  final GetRolesUseCase _getRolesUseCase;
  final CreateRoleUseCase _createRoleUsecase;
  final DeleteRoleUsecase _deleteRoleUsecase;
  final UpdateRoleUsecase _updateRoleUseCase;

  RemoteRolesBloc(this._getRolesUseCase, this._createRoleUsecase,
      this._deleteRoleUsecase, this._updateRoleUseCase)
      : super(const RemoteRolesLoading()) {
    on<GetRoles>(onGetRoles);
    on<CreateRoles>(onCreateRoles);
    on<DeleteRoles>(onDeleteRoles);
    on<UpdateRoles>(onUpdateRoles);
    on<RoleNameNotAvailable>((event, emit) {
      emit(RemoteRoleInitial());
    });
  }

  void onGetRoles(GetRoles event, Emitter<RemoteRolesState> emit) async {
    final dataState = await _getRolesUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteRolesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteRolesError(dataState.error!.message!));
    }
  }

  void onCreateRoles(CreateRoles event, Emitter<RemoteRolesState> emit) async {
    RoleEntity roleEntity = RoleEntity(name: event.rolename);
    final dataState = await _createRoleUsecase(params: roleEntity);
    if (dataState is DataSuccess) {
      emit(CreateRemoteRolesDone(dataState.data));
    }
    if (dataState is DataFailed) {
      emit(RemoteRolesError(dataState.error!.message!));
    }
  }

  void onDeleteRoles(DeleteRoles event, Emitter<RemoteRolesState> emit) async {
    RoleEntity roleEntity = RoleEntity(id: event.roleId);
    final dataState = await _deleteRoleUsecase(params: roleEntity);
    if (dataState is DataSuccess) {
      emit(DeleteRemoteRolesDone(dataState.data));
    }
    if (dataState is DataFailed) {
      emit(RemoteRolesError(dataState.error!.message!));
    }
  }

  void onUpdateRoles(UpdateRoles event, Emitter<RemoteRolesState> emit) async {
    RoleEntity roleEntity =
        RoleEntity(id: event.roleId, name: event.newRoleName);
    final dataState = await _updateRoleUseCase(params: roleEntity);
    if (dataState is DataSuccess) {
      emit(UpdateRolesDone(dataState.data));
    }
    if (dataState is DataFailed) {
      emit(RemoteRolesError(dataState.error!.message!));
    }
  }
}
