import 'package:hive_flutter/hive_flutter.dart';

part 'adminModel.g.dart';

@HiveType(typeId: 2)
class AdminModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String password;

  AdminModel({required this.username, required this.password, this.id});
}
