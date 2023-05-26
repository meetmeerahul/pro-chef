import 'package:hive_flutter/hive_flutter.dart';

part 'alert.g.dart';

@HiveType(typeId: 6)
class AlertModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final int recipeId;

  @HiveField(3)
  final String recipeName;

  @HiveField(4)
  final String image;

  AlertModel(
      {required this.username,
      required this.recipeId,
      this.id,
      required this.image,
      required this.recipeName});
}
