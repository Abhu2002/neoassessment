import 'package:equatable/equatable.dart';

abstract class RemoteStatusEvent extends Equatable {
  const RemoteStatusEvent();
}

class InitialStatusEvent extends RemoteStatusEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CreateStatusEvent extends RemoteStatusEvent {
  final String name;

  const CreateStatusEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class UpdateStatusEvent extends RemoteStatusEvent {
  final int id;
  final String name;

  const UpdateStatusEvent(this.id, this.name,);

  @override
  List<Object?> get props => [id, name,];
}

class DeleteStatusEvent extends RemoteStatusEvent {
  final int id;

  const DeleteStatusEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetStatusEvent extends RemoteStatusEvent {
  @override
  List<Object?> get props => [];
}
