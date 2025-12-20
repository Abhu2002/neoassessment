import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/domains/domain_entity.dart';
import 'package:neoassessment_flutter/domain/entities/roles/role_entity.dart';
import 'package:neoassessment_flutter/domain/usecases/candidates/get_candidates.dart';
import 'package:neoassessment_flutter/domain/usecases/roles/get_roles.dart';
import 'package:neoassessment_flutter/presentation/bloc/candidiates/remote_candidates_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/candidiates/remote_candidates_state.dart';

import '../../../core/utils/sharedPref.dart';
import '../../../domain/entities/candidates/candidate_entity.dart';
import '../../../domain/usecases/candidates/delete_candidate.dart';
import '../../../domain/usecases/candidates/login_candidate.dart';
import '../../../domain/usecases/candidates/register_candidate.dart';
import '../../../domain/usecases/candidates/update_candidate.dart';
import '../../../domain/usecases/domains/get_domains.dart';

class RemoteCandidatesBloc
    extends Bloc<RemoteCandidatesEvent, RemoteCandidatesState> {
  final LoginCandidateUseCase _loginCandidateUseCase;
  final GetCandidatesUseCase _getCandidatesUseCase;
  final GetDomainsUseCase _getDomainsUseCase;
  final GetRolesUseCase _getRolesUseCase;
  final RegisterCandidateUseCase _registerCandidateUsecase;

  final DeleteCandidateUseCase _deleteCandidateUseCase;
  final UpdateCandidateUseCase _updateCandidateUseCase;

  // final TokenCandidateUseCase _tokenCandidateUseCase;

  RemoteCandidatesBloc(
    this._loginCandidateUseCase,
    this._getCandidatesUseCase,
    this._getDomainsUseCase,
    this._getRolesUseCase,
    this._registerCandidateUsecase,
    this._deleteCandidateUseCase,
    this._updateCandidateUseCase,
    // this._tokenCandidateUseCase,
  ) : super(InitialCandidateState()) {
    on<InitialCandidateEvent>(onInitialCandidateEvent);
    on<LoginCandidateEvent>(onLoginCandidateEvent);
    on<GetCandidatesEvent>(onGetCandidatesEvent);
    on<CreateCandidateEvent>(onCreateCandidate);
    on<DeleteCandidateEvent>(onDeleteCandidates);
    on<UpdateCandidateEvent>(onUpdateCandidates);
    // on<VerifyTokenEvent>(onVerifyToken);
  }

  void onInitialCandidateEvent(
      InitialCandidateEvent event, Emitter<RemoteCandidatesState> emit) {
    emit(InitialCandidateState());
  }

  void onLoginCandidateEvent(
      LoginCandidateEvent event, Emitter<RemoteCandidatesState> emit) async {
    CandidateEntity userEntity =
        CandidateEntity(email: event.email, password: event.password);
    final dataState = await _loginCandidateUseCase(params: userEntity);

    if (dataState is DataSuccess) {
      CandidateEntity userEntity = dataState.data;
      await Prefs.setUser(jsonEncode(userEntity).toString());
      await Prefs.setAccessToken(userEntity.accessToken.toString());
      emit(LoginCandidateState(userEntity, dataState.message!));
    } else {
      emit(CandidateErrorState(dataState.error!.message!, DateTime.now()));
    }
  }

  void onGetCandidatesEvent(
      GetCandidatesEvent event, Emitter<RemoteCandidatesState> emit) async {
    final dataState = await _getCandidatesUseCase();
    final domainsState = await _getDomainsUseCase();
    final rolesState = await _getRolesUseCase();

    List<DomainEntity> domains = [];
    List<RoleEntity> roles = [];
    if (dataState is DataSuccess) {
      if (domainsState is DataSuccess) {
        domains = domainsState.data!;
      }
      if (rolesState is DataSuccess) {
        roles = rolesState.data!;
      }
      emit(
          LoadCandidatesState(dataState.data!, domains: domains, roles: roles));
    } else {
      emit(CandidateErrorState(dataState.error!.message!, DateTime.now()));
    }
  }

  // void onChangeDomainEvent(
  //     ChangeDomainEvent event, Emitter<RemoteCandidatesState> emit) async {
  //   emit(DomainChangedState(event.newDomain, event.domainId));
  // }
  //
  // void onChangeRolEvent(
  //     ChangeRoleEvent event, Emitter<RemoteCandidatesState> emit) async {
  //   emit(RoleChangedState(event.newRole, event.newRoleId));
  // }

  void onCreateCandidate(
      CreateCandidateEvent event, Emitter<RemoteCandidatesState> emit) async {
    CandidateEntity userEntity = CandidateEntity(
        firstName: event.firstname,
        lastName: event.lastName,
        email: event.emailId,
        phone: event.phone,
        dob: event.dob,
        domainId: event.domainId,
        experience: event.exp,
        password: event.password);
    final dataState = await _registerCandidateUsecase(params: userEntity);
    if (dataState is DataSuccess) {
      emit(CreateRemoteCandidateDone(dataState.message!));
    }
    if (dataState is DataFailed) {
      var now = DateTime.now();

      emit(CandidateErrorState(dataState.error!.message!, now));
    }
  }

  void onDeleteCandidates(
      DeleteCandidateEvent event, Emitter<RemoteCandidatesState> emit) async {
    final dataState = await _deleteCandidateUseCase(params: event.id);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(DeleteRemoteCandidatesDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      var time = DateTime.now();
      emit(CandidateErrorState(dataState.error.toString(), time));
    }
  }

  void onUpdateCandidates(
      UpdateCandidateEvent event, Emitter<RemoteCandidatesState> emit) async {
    CandidateEntity userEntity = CandidateEntity(
        id: event.id,
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        phone: event.phone,
        dob: event.dob,
        domainId: event.domainId,
        experience: event.exp,
        password: event.password);
    final dataState = await _updateCandidateUseCase(params: userEntity);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(UpdateCandidatesDone(dataState.data));
    }
    if (dataState is DataFailed) {
      var time = DateTime.now();
      emit(CandidateErrorState(dataState.error.toString(), time));
    }
  }

// void onVerifyToken(VerifyTokenEvent event, Emitter<RemoteCandidatesState> emit)async {
//   final dataState = await _tokenCandidateUseCase(params:event.token);
//   dynamic userObject = dataState.data;
//   DateTime datetime =DateTime.now();
//   print("Data:${dataState.data}");
//   await Prefs.setCandidateId(userObject[1]['user_id']);
//   if (dataState is DataSuccess && dataState.data!.isNotEmpty){
//     emit(VerifyTokenDone(dataState.data,datetime));
//   }
//   if(dataState is DataFailed){
//     var time = DateTime.now();
//     emit(CandidateErrorState(dataState.error.toString(), time));
//
//   }
// }
}
