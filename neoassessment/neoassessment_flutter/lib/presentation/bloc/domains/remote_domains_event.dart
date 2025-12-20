part of 'remote_domains_bloc.dart';

abstract class RemoteDomainsEvent extends Equatable {
  const RemoteDomainsEvent();
}

class InitialDomainsEvent extends RemoteDomainsEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CreateDomainEvent extends RemoteDomainsEvent {
  final String name;
  final String description;

  const CreateDomainEvent(this.name, this.description);

  @override
  List<Object?> get props => [name, description];
}

class UpdateDomainEvent extends RemoteDomainsEvent {
  final int id;
  final String name;
  final String description;

  const UpdateDomainEvent(this.id, this.name, this.description);

  @override
  List<Object?> get props => [id, name, description];
}

class DeleteDomainEvent extends RemoteDomainsEvent {
  final int id;

  const DeleteDomainEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetDomainsEvent extends RemoteDomainsEvent {
  @override
  List<Object?> get props => [];
}
