import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:prochef/functions/dbFav.dart';
import 'package:prochef/models/comment.dart';
import 'package:prochef/models/favourite.dart';
import 'package:prochef/models/recipe.dart';

ValueNotifier<List<RecipeModel>> recipeListNotifier = ValueNotifier([]);

ValueNotifier<List<RecipeModel>> recipeCategoryNotifier = ValueNotifier([]);

ValueNotifier<List<RecipeModel>> recipeNotifier = ValueNotifier([]);

ValueNotifier<List<RecipeModel>> getImage = ValueNotifier([]);

Future<void> uploadRecipe(RecipeModel value) async {
  final recipebox = await Hive.openBox<RecipeModel>('recipe');
  await recipebox.add(value);
  getAllRecipes();
}

Future<void> getAllRecipes() async {
  final recipeDB = await Hive.openBox<RecipeModel>('recipe');
  recipeListNotifier.value.clear();

  recipeListNotifier.value.addAll(recipeDB.values);

  recipeListNotifier.notifyListeners();
}

Future<void> getRecipe() async {
  // typeID as  required argument
  final recipeDB = await Hive.openBox<RecipeModel>('recipe');
  recipeNotifier.value.clear();

  var data = recipeDB.values.toList();

  for (var item in data) {
    if (item.isVisible == true) {
      recipeNotifier.value.add(item);
      recipeNotifier.notifyListeners();
    }
  }
}

Future<void> deleteRecipe(int id) async {
  final commentDB = await Hive.openBox<CommentModel>('comment');

  var commentData = commentDB.values.toList();

  int commentIndex = 0;
  for (var comment in commentData) {
    if (comment.recipeId == id) {
      commentDB.deleteAt(commentIndex);
    }
    commentIndex++;
  }

  final favouriteDB = await Hive.openBox<FavouriteModel>('favourite');

  var favouriteData = favouriteDB.values.toList();

  int favIndex = 0;

  favListNotifier.value.clear();
  favListNotifier.notifyListeners();
  for (var favourite in favouriteData) {
    if (favourite.recipeId == id) {
      favouriteDB.deleteAt(favIndex);
    }
    favIndex++;
  }

  final recipeDB = await Hive.openBox<RecipeModel>('recipe');
  recipeDB.deleteAt(id);

  getAllRecipes();
}

Future<void> getRecipeByCategory(String categoryChoosen) async {
  final recipeDB = await Hive.openBox<RecipeModel>('recipe');
  final recipes = recipeDB.values.toList();

  recipeCategoryNotifier.value.clear();

  if (categoryChoosen == "Vegetarian") {
    String type = "Veg";
    for (var recipe in recipes) {
      if (recipe.type == type) {
        recipeCategoryNotifier.value.add(recipe);
        recipeCategoryNotifier.notifyListeners();
      }
    }
  } else {
    for (var recipe in recipes) {
      if (recipe.category == categoryChoosen) {
        recipeCategoryNotifier.value.add(recipe);
        recipeCategoryNotifier.notifyListeners();
      }
    }
  }
}

Future<void> getIndividualRecipe(int id) async {
  final recipeDB = await Hive.openBox<RecipeModel>('recipe');
  recipeDB.values.toList();
}
