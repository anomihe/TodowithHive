import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtodo/bloc/home_event.dart';
import 'package:newtodo/bloc/home_state.dart';
import 'package:newtodo/services/authentication.dart';
import 'package:newtodo/services/todoservices.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationServices services;
  final Todo todo;
  HomeBloc({required this.services, required this.todo})
      : super(const HomeInitial()) {
    on<LoginEvent>(
      ((event, emit) async {
        final result = await services.authenticateUser(
          event.username,
          event.password,
        );
        if (result != null) {
          emit(SuccessfullLoginState(username: result));
          emit(const HomeInitial());
        }
      }),
    );
    on<RegisterAccountEvents>((event, emit) async {
      final result = await services.createUser(event.username, event.password);
      switch (result) {
        case UserCreationResult.success:
          emit(SuccessfullLoginState(username: event.username));
          break;
        case UserCreationResult.failure:
          emit(const HomeInitial(error: 'there has some error'));
          break;
        case UserCreationResult.already_exists:
          emit(const HomeInitial(error: 'user already exits'));
          break;
        default:
      }
    });
    on<RegistrationServicesEvent>((event, emit) async {
      // await _auth.init();
      // await _todo.init();
      emit(const HomeInitial());
    });
  }
}
