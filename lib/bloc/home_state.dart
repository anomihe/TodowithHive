import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  //final bool? success;
  final String? error;
  const HomeInitial({this.error});
  @override
  List<Object?> get props => [error];
}

class SuccessfullLoginState extends HomeState {
  final String username;

  const SuccessfullLoginState({required this.username});

  @override
  List<Object?> get props => [username];
}

class RegistrationService extends HomeState {
  @override
  List<Object?> get props => [];
}
