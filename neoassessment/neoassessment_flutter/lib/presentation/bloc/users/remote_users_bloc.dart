import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/domains/domain_entity.dart';
import 'package:neoassessment_flutter/domain/entities/roles/role_entity.dart';
import 'package:neoassessment_flutter/domain/entities/users/user_entity.dart';
import 'package:neoassessment_flutter/domain/usecases/roles/get_roles.dart';
import 'package:neoassessment_flutter/domain/usecases/users/get_users.dart';
import 'package:neoassessment_flutter/domain/usecases/users/login_user.dart';
import 'package:neoassessment_flutter/presentation/bloc/users/remote_users_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/users/remote_users_state.dart';

import '../../../core/utils/sharedPref.dart';
import '../../../domain/entities/candidates/candidate_entity.dart';
import '../../../domain/usecases/candidates/login_candidate.dart';
import '../../../domain/usecases/domains/get_domains.dart';
import '../../../domain/usecases/users/delete_user.dart';
import '../../../domain/usecases/users/register_user.dart';
import '../../../domain/usecases/users/update_users.dart';
import '../../../domain/usecases/users/verify_token.dart';

class RemoteUsersBloc extends Bloc<RemoteUsersEvent, RemoteUsersState> {
  final LoginUserUseCase _loginUserUseCase;
  final GetUsersUseCase _getUsersUseCase;
  final GetDomainsUseCase _getDomainsUseCase;
  final GetRolesUseCase _getRolesUseCase;
  final RegisterUserUseCase _registerUserUsecase;
  final DeleteUserUseCase _deleteUserUseCase;
  final UpdateUsersUseCase _updateUserUseCase;
  final TokenUserUseCase _tokenUserUseCase;
  final LoginCandidateUseCase _loginCandidateUseCase;

  RemoteUsersBloc(
      this._loginUserUseCase,
      this._getUsersUseCase,
      this._getDomainsUseCase,
      this._getRolesUseCase,
      this._registerUserUsecase,
      this._deleteUserUseCase,
      this._updateUserUseCase,
      this._tokenUserUseCase,
      this._loginCandidateUseCase)
      : super(InitialUserState()) {
    on<InitialUserEvent>(onInitialUserEvent);
    on<LoginUserEvent>(onLoginUserEvent);
    on<GetUsersEvent>(onGetUsersEvent);
    on<ChangeDomainEvent>(onChangeDomainEvent);
    on<ChangeRoleEvent>(onChangeRolEvent);
    on<CreateUserEvent>(onCreateUser);
    on<DeleteUserEvent>(onDeleteUsers);
    on<UpdateUserEvent>(onUpdateUsers);
    on<VerifyTokenEvent>(onVerifyToken);
    on<UserTypeEvent>( onSetUserType);
    on<LoginUserCandidateEvent>(onLoginCandidateEvent);
  }

  void onInitialUserEvent(
      InitialUserEvent event, Emitter<RemoteUsersState> emit) {
    emit(InitialUserState());
  }

  void onLoginUserEvent(
      LoginUserEvent event, Emitter<RemoteUsersState> emit) async {
    UserEntity userEntity =
        UserEntity(email: event.email, password: event.password);
    final dataState = await _loginUserUseCase(params: userEntity);

    if (dataState is DataSuccess) {
      UserEntity userEntity = dataState.data;
      Map<String,dynamic> usertype = {"user":userEntity,"user_type":"staff"};
     // await Prefs.setUser(jsonEncode(userEntity).toString());
      String jsonencoded = jsonEncode(usertype);
      await Prefs.setUser(jsonencoded);
      await Prefs.setAccessToken(userEntity.accessToken.toString());
      emit(LoginUserState(userEntity, dataState.message!));
    } else {
      emit(UserErrorState(dataState.error!.message!, DateTime.now()));
    }
  }

  void onGetUsersEvent(
      GetUsersEvent event, Emitter<RemoteUsersState> emit) async {
    final dataState = await _getUsersUseCase();
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
      emit(LoadUsersState(dataState.data!, domains: domains, roles: roles));
    } else {
      emit(UserErrorState(dataState.error!.message!, DateTime.now()));
    }
  }

  void onChangeDomainEvent(
      ChangeDomainEvent event, Emitter<RemoteUsersState> emit) async {
    emit(DomainChangedState(event.newDomain, event.domainId));
  }

  void onChangeRolEvent(
      ChangeRoleEvent event, Emitter<RemoteUsersState> emit) async {
    emit(RoleChangedState(event.newRole, event.newRoleId));
  }

  void onCreateUser(
      CreateUserEvent event, Emitter<RemoteUsersState> emit) async {
    UserEntity userEntity = UserEntity(
        firstName: event.firstname,
        lastName: event.lastName,
        email: event.emailId,
        phone: event.phone,
        dob: event.dob,
        domainId: event.domainId,
        roleId: event.roleId,
        experience: event.exp,
        password: event.password);
    final dataState = await _registerUserUsecase(params: userEntity);
    if (dataState is DataSuccess) {
      emit(CreateRemoteUserDone(dataState.message!));
    }
    if (dataState is DataFailed) {
      var now = DateTime.now();
      // ignore: unused_local_variable
      var formatter = DateFormat.yMd();

      emit(UserErrorState(dataState.error!.message!, now));
    }
  }

  void onDeleteUsers(
      DeleteUserEvent event, Emitter<RemoteUsersState> emit) async {
    UserEntity userEntity = UserEntity(id: event.id);
    final dataState = await _deleteUserUseCase(params: userEntity);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(DeleteRemoteUsersDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      var time = DateTime.now();
      emit(UserErrorState(dataState.error.toString(), time));
    }
  }

  void onUpdateUsers(
      UpdateUserEvent event, Emitter<RemoteUsersState> emit) async {
    UserEntity userEntity = UserEntity(
        id: event.id,
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        phone: event.phone,
        dob: event.dob,
        domainId: event.domainId,
        roleId: event.roleId,
        experience: event.exp,
        password: event.password);
    final dataState = await _updateUserUseCase(params: userEntity);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(UpdateUsersDone(dataState.data));
    }
    if (dataState is DataFailed) {
      var time = DateTime.now();
      emit(UserErrorState(dataState.error.toString(), time));
    }
  }

  void onVerifyToken(
      VerifyTokenEvent event, Emitter<RemoteUsersState> emit) async {
    final dataState = await _tokenUserUseCase(params: event.token);
    dynamic userObject = dataState.data;
    print("onVerifyToken : $userObject");
    DateTime datetime = DateTime.now();
    await Prefs.setUserId(userObject[1]['user_id']);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(VerifyTokenDone(dataState.data, datetime));
    }
    if (dataState is DataFailed) {
      var time = DateTime.now();
      emit(UserErrorState(dataState.error.toString(), time));
    }
  }

  void onSetUserType(UserTypeEvent event,Emitter<RemoteUsersState> emit) async {
    emit(UserTypeState(event.type));
  }


  void onLoginCandidateEvent(
      LoginUserCandidateEvent event, Emitter<RemoteUsersState> emit) async {
    CandidateEntity userEntity =
    CandidateEntity(email: event.email, password: event.password);
    final dataState = await _loginCandidateUseCase(params: userEntity);

    if (dataState is DataSuccess) {
      CandidateEntity userEntity = dataState.data;
      Map<String,dynamic> usertype = {"user": userEntity,"user_type":"candidate"};
     // await Prefs.setUser(jsonEncode(userEntity).toString());
      String jsonencoded = jsonEncode(usertype);
      await Prefs.setUser(jsonencoded);
      await Prefs.setAccessToken(userEntity.accessToken.toString());
      emit(LoginUserCandidateState(userEntity, dataState.message!));
    } else {
      emit(CandidateUserErrorState(dataState.error!.message!, DateTime.now()));
    }
  }
}
