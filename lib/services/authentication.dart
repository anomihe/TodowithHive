import 'dart:math';

import 'package:hive/hive.dart';
import 'package:newtodo/model/user.dart';

class AuthenticationServices {
  // ignore: unused_field
  late final Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox('userBox');
  }

  Future<String?> authenticateUser(
      final String username, final String password) async {
    // ignore: await_only_futures
    final success = await _users.values.any((element) =>
        element.username == username && element.password == password);
    if (success) {
      return username;
    } else {
      return null;
    }
  }

  Future<UserCreationResult> createUser(
      final String username, final String password) async {
    final already_exists = _users.values.any(
      (element) => element.username.toLowerCase() == username.toLowerCase(),
    );
    if (already_exists) {
      return UserCreationResult.already_exists;
    }
    try {
      _users.add(User(username: username, password: password));
      return UserCreationResult.success;
    } on Exception catch (ex) {
      return UserCreationResult.failure;
    }
  }
}

enum UserCreationResult {
  success,
  failure,
  already_exists,
}
