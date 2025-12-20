import 'package:equatable/equatable.dart';
import 'package:neoassessment_flutter/domain/entities/response/response_entity.dart';

abstract class RemoteResponseEvent extends Equatable {
  const RemoteResponseEvent();
}

class GetResponsesEvent extends RemoteResponseEvent {
  const GetResponsesEvent();

  @override
  List<Object?> get props => [];
}

class UpdateResponseEvent extends RemoteResponseEvent {
  final ResponseEntity responseEntity;

  const UpdateResponseEvent({required this.responseEntity});

  @override
  List<Object?> get props => [responseEntity];
}

class DeleteResponseEvent extends RemoteResponseEvent {
  final int responseId;

  const DeleteResponseEvent(this.responseId);

  @override
  List<Object?> get props => [responseId];
}
