import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newtodo/services/todoservices.dart';
import 'package:newtodo/todo/todo_events.dart';
import 'package:newtodo/todo/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Todo todo;
  TodoBloc(this.todo) : super(TodoInitial()) {
    on<LoadToadEvent>(((event, emit) {
      final tod = todo.getTasks(event.username);
      emit(TodoLoadedState(tod, event.username));
    }));

    on<AddTodoEvent>((event, emit) async {
      final currentState = state as TodoLoadedState;
      todo.addTask(event.todoText, currentState.username);
      add(LoadToadEvent(currentState.username));
    });

    on<ToggleTodoState>((event, emit) async {
      final currentState = state as TodoLoadedState;
      await todo.updateTask(event.todoTask, currentState.username);
      add(LoadToadEvent(currentState.username));
    });
  }
}
