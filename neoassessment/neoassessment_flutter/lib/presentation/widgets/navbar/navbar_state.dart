part of 'navbar_bloc.dart';

sealed class NavbarState extends Equatable {
  const NavbarState();

  @override
  List<Object> get props => [];
}

final class NavbarInitial extends NavbarState {}

class NavbarLoaded extends NavbarState {
  int index = 0;

  NavbarLoaded(this.index);

  @override
  List<Object> get props => [index];
}

class NavbarErrorState extends NavbarState {
  final String errorMessage;

  const NavbarErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
