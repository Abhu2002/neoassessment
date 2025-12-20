import 'package:equatable/equatable.dart';
import 'package:neoassessment_flutter/domain/entities/questionCat/questionCat_entity.dart';

import '../../../domain/entities/domains/domain_entity.dart';

abstract class RemoteQuestionCatState extends Equatable {
  const RemoteQuestionCatState();

  @override
  List<Object?> get props => [];
}

class RemoteQuestionCatInitial extends RemoteQuestionCatState {}

class RemoteQuestionCatLoading extends RemoteQuestionCatState {
  const RemoteQuestionCatLoading();
}

class RemoteQuestionCatDone extends RemoteQuestionCatState {
  final List<QuestionCatEntity> result;
  final List<DomainEntity>? domains;

  const RemoteQuestionCatDone(this.result, {this.domains});

  @override
  List<Object> get props => [result, domains!];
}

class RemoteQuestionCatError extends RemoteQuestionCatState {
  final String errormsg;

  const RemoteQuestionCatError(this.errormsg);

  @override
  List<Object> get props => [errormsg];
}

class DeleteRemoteQuestionCatDone extends RemoteQuestionCatState {
  final String message;

  const DeleteRemoteQuestionCatDone(this.message);

  @override
  List<Object> get props => [message];
}

class QuestionCatCreatedState extends RemoteQuestionCatState {
  final String message;

  const QuestionCatCreatedState(this.message);

  @override
  List<Object?> get props => [message];
}

class DomainChangedState extends RemoteQuestionCatState {
  final String newDomain;
  final int domainId;

  const DomainChangedState(this.newDomain, this.domainId);

  @override
  List<Object?> get props => [newDomain];
}

class QuestionCatUpdatedState extends RemoteQuestionCatState {
  final String message;

  const QuestionCatUpdatedState(this.message);

  @override
  List<Object?> get props => [message];
}
