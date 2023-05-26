import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prochef/models/adminModel.dart';

ValueNotifier<List<AdminModel>> adminNotifier = ValueNotifier([]);

Future<void> createAdmin(AdminModel admin) async {
  print(admin);
  final adminData = await Hive.openBox<AdminModel>('admin');
  await adminData.add(admin);
}
