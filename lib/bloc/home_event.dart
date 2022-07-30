import 'package:equatable/equatable.dart';
import 'package:newtodo/todo/todo_events.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoginEvent extends HomeEvent {
  final String username;
  final String password;

  const LoginEvent(this.username, this.password);
  @override
  List<Object?> get props => [username, password];
}

class RegistrationServicesEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class RegisterAccountEvents extends HomeEvent {
  final String username;
  final String password;

  const RegisterAccountEvents(this.username, this.password);
  @override
  List<Object?> get props => [username, password];
}
