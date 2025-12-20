import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/usecases/domains/delete_domain.dart';
import 'package:neoassessment_flutter/domain/usecases/domains/update_domain.dart';

import '../../../domain/entities/domains/domain_entity.dart';
import '../../../domain/usecases/domains/create_domain.dart';
import '../../../domain/usecases/domains/get_domains.dart';

part 'remote_domains_event.dart';
part 'remote_domains_state.dart';

class RemoteDomainsBloc extends Bloc<RemoteDomainsEvent, RemoteDomainsState> {
  final GetDomainsUseCase _domainsUseCase;
  final CreateDomainUseCase _createDomainUseCase;
  final UpdateDomainUseCase _updateDomainUseCase;
  final DeleteDomainUseCase _deleteDomainUseCase;

  RemoteDomainsBloc(
    this._domainsUseCase,
    this._createDomainUseCase,
    this._updateDomainUseCase,
    this._deleteDomainUseCase,
  ) : super(InitialDomainsState()) {
    on<InitialDomainsEvent>(onInitialDomainsEvent);
    on<GetDomainsEvent>(onGetDomainsEvent);
    on<CreateDomainEvent>(onCreateDomainEvent);
    on<UpdateDomainEvent>(onUpdateDomainEvent);
    on<DeleteDomainEvent>(onDeleteDomainEvent);
  }

  void onInitialDomainsEvent(
      InitialDomainsEvent event, Emitter<RemoteDomainsState> emit) {
    emit(InitialDomainsState());
  }

  void onGetDomainsEvent(
      GetDomainsEvent event, Emitter<RemoteDomainsState> emit) async {
    final dataState = await _domainsUseCase();
    if (dataState is DataSuccess) {
      emit(LoadDomainsState(dataState.data!));
    } else {
      emit(RemoteDomainsError(dataState.error!.message!));
    }
  }

  void onCreateDomainEvent(
      CreateDomainEvent event, Emitter<RemoteDomainsState> emit) async {
    DomainEntity domainEntity = DomainEntity(
      name: event.name,
      description: event.description,
    );
    final dataState = await _createDomainUseCase(params: domainEntity);

    if (dataState is DataSuccess) {
      emit(DomainCreatedState(dataState.message!));
    } else {
      emit(RemoteDomainsError(dataState.error!.message!));
    }
  }

  void onUpdateDomainEvent(
      UpdateDomainEvent event, Emitter<RemoteDomainsState> emit) async {
    DomainEntity domainEntity = DomainEntity(
      id: event.id,
      name: event.name,
      description: event.description,
    );
    final dataState = await _updateDomainUseCase(params: domainEntity);

    if (dataState is DataSuccess) {
      emit(DomainUpdatedState(dataState.message!));
    } else {
      emit(RemoteDomainsError(dataState.error!.message!));
    }
  }

  void onDeleteDomainEvent(
      DeleteDomainEvent event, Emitter<RemoteDomainsState> emit) async {
    final dataState = await _deleteDomainUseCase(params: event.id);

    if (dataState is DataSuccess) {
      emit(DomainDeletedState(dataState.message!));
    } else {
      emit(RemoteDomainsError(dataState.error!.message!));
    }
  }
}
