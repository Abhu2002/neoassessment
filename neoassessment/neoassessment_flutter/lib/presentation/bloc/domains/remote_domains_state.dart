part of 'remote_domains_bloc.dart';

abstract class RemoteDomainsState extends Equatable {
  const RemoteDomainsState();
}

class InitialDomainsState extends RemoteDomainsState {
  @override
  List<Object?> get props => [];
}

class LoadDomainsState extends RemoteDomainsState {
  final List<DomainEntity> domains;

  const LoadDomainsState(this.domains);

  @override
  List<Object?> get props => [domains];
}

class DomainCreatedState extends RemoteDomainsState {
  final String message;

  const DomainCreatedState(this.message);

  @override
  List<Object?> get props => [message];
}

class DomainUpdatedState extends RemoteDomainsState {
  final String message;

  const DomainUpdatedState(this.message);

  @override
  List<Object?> get props => [message];
}

class DomainDeletedState extends RemoteDomainsState {
  final String message;

  const DomainDeletedState(this.message);

  @override
  List<Object?> get props => [message];
}

class RemoteDomainsError extends RemoteDomainsState {
  final String message;

  const RemoteDomainsError(this.message);

  @override
  List<Object?> get props => [message];
}
