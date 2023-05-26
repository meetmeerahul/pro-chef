import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:prochef/commonscreens/viewrecipe.dart';
import 'package:prochef/functions/dbRecipe.dart';

import 'package:prochef/models/recipe.dart';

class ViewRecipeFromFav extends StatefulWidget {
  ViewRecipeFromFav({super.key, required this.index});

  final int index;

  @override
  State<ViewRecipeFromFav> createState() => _ViewRecipeFromFavState();
}

class _ViewRecipeFromFavState extends State<ViewRecipeFromFav> {
  int get index => widget.index;

  @override
  Widget build(BuildContext context) {
    var recipe = getRecipes(index: index);

    print("list is $recipe");

    return Scaffold(body: SafeArea(child: Text(index.toString())));
  }

  Future<dynamic> getRecipes({required int index}) async {
    var recipeDb = await Hive.openBox<RecipeModel>('recipe');
    var data = recipeDb.values.toList();
    onButtonTapped(
      data: data[index],
      index: index,
    );
  }

  void onButtonTapped({required int index, required RecipeModel data}) async {
    await Future.delayed(const Duration(microseconds: 0));

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (ctx) => RecipeView(
          passId: index,
          passValue: data,
        ),
      ),
      (route) => false,
    );
  }
}
