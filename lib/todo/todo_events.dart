// part of 'todo_bloc.dart'
import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class LoadToadEvent extends TodoEvent {
  final String username;
  const LoadToadEvent(this.username);

  @override
  List<Object> get props => [username];
}

class AddTodoEvent extends TodoEvent {
  final String todoText;
  const AddTodoEvent(this.todoText);
  @override
  List<Object?> get props => [todoText];
}

class ToggleTodoState extends TodoEvent {
  final String todoTask;

  const ToggleTodoState(this.todoTask);

  @override
  List<Object?> get props => [todoTask];
}
