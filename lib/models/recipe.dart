import 'dart:core';

import 'package:hive_flutter/hive_flutter.dart';

part 'recipe.g.dart';

@HiveType(typeId: 3)
class RecipeModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String type;

  @HiveField(4)
  final String servings;

  @HiveField(5)
  final String ingrediants;

  @HiveField(6)
  final String directions;

  @HiveField(7)
  final String category;

  @HiveField(8)
  final String image;

  @HiveField(9)
  final String duration;

  @HiveField(10)
  final bool isVisible;

  @HiveField(11)
  final int totalFav;

  RecipeModel(
      {required this.name,
      required this.category,
      required this.type,
      required this.image,
      required this.servings,
      required this.ingrediants,
      required this.directions,
      required this.description,
      required this.duration,
      required this.isVisible,
      this.totalFav = 0,
      this.id});
}
