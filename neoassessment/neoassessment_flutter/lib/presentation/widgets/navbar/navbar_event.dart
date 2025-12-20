part of 'navbar_bloc.dart';

sealed class NavbarEvent extends Equatable {
  const NavbarEvent();

  @override
  List<Object> get props => [];
}

class NavbarInitEvent extends NavbarEvent {
  int index;

  NavbarInitEvent(this.index);
}
