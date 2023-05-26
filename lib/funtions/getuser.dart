import 'package:hive_flutter/hive_flutter.dart';
import 'package:prochef/commonscreens/ProfileScreen.dart';
import 'package:prochef/main.dart';
import 'package:prochef/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserModel> getUser() async {
  doCreateTheUserBox();

  getUserName();

  print('Get user called');
  final userBox = await Hive.openBox<UserModel>('prochef');

  var users =
      userBox.values.where((user) => user.username == LOGGED_USERNAME).toList();

  if (users.isNotEmpty) {
    UserModel user = users.first;

    return user;
  } else {
    throw ("Usernot found");
  }
}

Future<void> doCreateTheUserBox() async {
  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }

  await Hive.openBox<UserModel>('prochef');
}

Future<void> getUserName() async {
  final _userNameShared = await SharedPreferences.getInstance();

  final _usernameLogged = _userNameShared.getString('username');

  LOGGED_USERNAME = _usernameLogged!;
}
