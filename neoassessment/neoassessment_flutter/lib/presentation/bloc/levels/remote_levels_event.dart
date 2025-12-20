import 'package:equatable/equatable.dart';

abstract class RemoteLevelsEvent extends Equatable {
  const RemoteLevelsEvent();
}

class InitialDomainsEvent extends RemoteLevelsEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CreateLevelEvent extends RemoteLevelsEvent {
  final int number;

  CreateLevelEvent(this.number);

  @override
  List<Object?> get props => [number];
}

class UpdateLevelEvent extends RemoteLevelsEvent {
  final int id;
  final int level;

  const UpdateLevelEvent(this.id, this.level);

  @override
  List<Object?> get props => [id, level];
}

class DeleteLevelEvent extends RemoteLevelsEvent {
  final int id;

  const DeleteLevelEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetLevelEvent extends RemoteLevelsEvent {
  @override
  List<Object?> get props => [];
}
