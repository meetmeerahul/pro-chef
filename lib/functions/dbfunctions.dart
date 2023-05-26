import 'package:hive_flutter/hive_flutter.dart';

import 'package:prochef/models/userModel.dart';

Future<void> createUser(UserModel value) async {
  print(value.id);
  print(value.password);
  final userDB = await Hive.openBox<UserModel>('prochef');
  await userDB.add(value);
}
