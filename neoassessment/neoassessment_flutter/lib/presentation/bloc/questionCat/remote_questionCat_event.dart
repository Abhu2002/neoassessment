import 'package:equatable/equatable.dart';

abstract class RemoteQuestionCatEvent extends Equatable {
  const RemoteQuestionCatEvent();
}

class GetQuestionCatEvent extends RemoteQuestionCatEvent {
  const GetQuestionCatEvent();

  @override
  List<Object?> get props => [];
}

class DeleteQuestionCatEvent extends RemoteQuestionCatEvent {
  final int id;

  const DeleteQuestionCatEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateQuestionCatEvent extends RemoteQuestionCatEvent {
  final int domainId;
  final String name;
  final String description;

  const CreateQuestionCatEvent(this.domainId, this.name, this.description);

  @override
  List<Object?> get props => [domainId, name, description];
}

class ChangeDomainQuestionCatEvent extends RemoteQuestionCatEvent {
  final String newDomain;
  final int domainId;

  const ChangeDomainQuestionCatEvent(this.newDomain, this.domainId);

  @override
  List<Object?> get props => [newDomain, domainId];
}

class UpdateQuestionCatEvent extends RemoteQuestionCatEvent {
  final int id;
  final int domainId;
  final String name;
  final String description;

  const UpdateQuestionCatEvent(
      this.id, this.domainId, this.name, this.description);

  @override
  List<Object?> get props => [id, domainId, name, description];
}
