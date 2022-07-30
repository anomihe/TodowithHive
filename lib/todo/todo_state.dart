// part of 'todo_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newtodo/model/task.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoadedState extends TodoState {
  final List<Task> task;
  final String username;
  const TodoLoadedState(this.task, this.username);

  @override
  List<Object> get props => [task, username];
}
