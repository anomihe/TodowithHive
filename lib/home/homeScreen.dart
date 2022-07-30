import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtodo/bloc/home_bloc.dart';
import 'package:newtodo/bloc/home_event.dart';
import 'package:newtodo/bloc/home_state.dart';
import 'package:newtodo/services/authentication.dart';
import 'package:newtodo/services/todoservices.dart';
import 'package:newtodo/todo/todo_ui/todo_ui.dart';

class HomePage extends StatelessWidget {
  final usernameField = TextEditingController();
  final passwordField = TextEditingController();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login To TOdo App',
        ),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
          services: RepositoryProvider.of<AuthenticationServices>(context),
          todo: RepositoryProvider.of<Todo>(context),
        )..add(RegistrationServicesEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessfullLoginState) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TodosPage(
                        username: state.username,
                      )));
            }
            if (state is HomeInitial) {
              if (state.error != null) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: Text(state.error!),
                        ));
              }
            }
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              return Column(
                children: [
                  TextField(
                    controller: usernameField,
                    decoration: const InputDecoration(
                      labelText: 'username',
                    ),
                  ),
                  TextField(
                    controller: passwordField,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'password',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<HomeBloc>(context).add(
                                LoginEvent(
                                  usernameField.text,
                                  passwordField.text,
                                ),
                              );
                            },
                            child: const Text('LOGIN')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<HomeBloc>(context).add(
                                RegisterAccountEvents(
                                  usernameField.text,
                                  passwordField.text,
                                ),
                              );
                            },
                            child: const Text('REGISTER')),
                      ),
                    ],
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
