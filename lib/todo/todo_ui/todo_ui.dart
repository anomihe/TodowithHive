import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtodo/todo/todo_bloc.dart';
import 'package:newtodo/todo/todo_events.dart';
import 'package:newtodo/todo/todo_state.dart';

class TodosPage extends StatelessWidget {
  final String username;

  const TodosPage({Key? key, required this.username}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: BlocProvider(
        create: (context) => TodoBloc(RepositoryProvider.of(context))
          ..add(
            LoadToadEvent(
              username,
            ),
          ),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoadedState) {
              return ListView(children: [
                ...state.task.map((e) => ListTile(
                      title: Text(e.task),
                      trailing: Checkbox(
                        value: e.completed,
                        onChanged: (val) {
                          BlocProvider.of<TodoBloc>(context)
                              .add(ToggleTodoState(e.task));
                        },
                      ),
                    )),
                ListTile(
                  title: const Text('Create new Task'),
                  trailing: const Icon(Icons.create),
                  onTap: () async {
                    final result = await showDialog<String>(
                        context: context,
                        builder: (context) => const Dialog(
                              child: CreateNewTask(),
                            ));

                    if (result != null) {
                      BlocProvider.of<TodoBloc>(context)
                          .add(AddTodoEvent(result));
                    }
                  },
                )
              ]);
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key}) : super(key: key);
  @override
  State<CreateNewTask> createState() => CreateNewTaskState();
}

class CreateNewTaskState extends State<CreateNewTask> {
  final _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('What task do you want to create'),
        TextField(
          controller: _inputController,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(_inputController.text);
            },
            child: const Text('SAVE'))
      ],
    );
  }
}
