import 'package:equatable/equatable.dart';

import '../../../domain/entities/status/status_entity.dart';

abstract class RemoteStatusState extends Equatable {
  const RemoteStatusState();
}

class InitialStatusState extends RemoteStatusState {
  @override
  List<Object?> get props => [];
}

class LoadStatusState extends RemoteStatusState {
  final List<StatusEntity> domains;

  const LoadStatusState(this.domains);

  @override
  List<Object?> get props => [domains];
}

class StatusCreatedState extends RemoteStatusState {
  final String message;

  const StatusCreatedState(this.message);

  @override
  List<Object?> get props => [message];
}

class StatusUpdatedState extends RemoteStatusState {
  final String message;

  const StatusUpdatedState(this.message);

  @override
  List<Object?> get props => [message];
}

class StatusDeletedState extends RemoteStatusState {
  final String message;

  const StatusDeletedState(this.message);

  @override
  List<Object?> get props => [message];
}

class RemoteStatusError extends RemoteStatusState {
  final String message;

  const RemoteStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
