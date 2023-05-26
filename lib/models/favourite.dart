import 'package:hive_flutter/hive_flutter.dart';

part 'favourite.g.dart';

@HiveType(typeId: 4)
class FavouriteModel {
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

  FavouriteModel(
      {required this.username,
      required this.recipeId,
      this.id,
      required this.image,
      required this.recipeName});
}
