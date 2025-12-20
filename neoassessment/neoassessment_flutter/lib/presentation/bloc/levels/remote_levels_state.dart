import 'package:equatable/equatable.dart';

import '../../../domain/entities/level/level_entity.dart';

abstract class RemoteLevelsState extends Equatable {
  const RemoteLevelsState();

  @override
  List<Object?> get props => [];
}

class RemoteLevelInitial extends RemoteLevelsState {}

class RemoteLevelLoading extends RemoteLevelsState {
  const RemoteLevelLoading();
}

class RemoteLevelsDone extends RemoteLevelsState {
  final List<LevelEntity> result;

  const RemoteLevelsDone(this.result);

  @override
  List<Object> get props => [result];
}

class CreateRemoteLevelsDone extends RemoteLevelsState {
  final String message;

  const CreateRemoteLevelsDone(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteRemoteLevelsDone extends RemoteLevelsState {
  final String message;

  const DeleteRemoteLevelsDone(this.message);

  @override
  List<Object> get props => [message];
}

class RemoteLevelsError extends RemoteLevelsState {
  final String errormsg;

  const RemoteLevelsError(this.errormsg);

  @override
  List<Object> get props => [errormsg];
}

class UpdateLevelsDone extends RemoteLevelsState {
  final String message;

  const UpdateLevelsDone(this.message);

  @override
  List<Object> get props => [message];
}
