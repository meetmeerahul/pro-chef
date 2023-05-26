import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:prochef/adminscreens/updaterecipe.dart';
import 'package:prochef/commonscreens/viewrecipe.dart';
import 'package:prochef/functions/dbRecipe.dart';

import 'package:prochef/models/recipe.dart';

class ManageRecipeGrid extends StatefulWidget {
  const ManageRecipeGrid({Key? key}) : super(key: key);

  @override
  State<ManageRecipeGrid> createState() => _ManageRecipeGridState();
}

class _ManageRecipeGridState extends State<ManageRecipeGrid> {
  late Box<RecipeModel> recipeBox;

  @override
  void initState() {
    super.initState();

    recipeBox = Hive.box('recipe');
  }

  @override
  Widget build(BuildContext context) {
    getAllRecipes();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ValueListenableBuilder(
          valueListenable: recipeListNotifier,
          builder:
              (BuildContext ctx, List<RecipeModel> recipeList, Widget? child) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 1000,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10),
              itemCount: recipeList.length,
              itemBuilder: (BuildContext ctx, index) {
                final data = recipeList[index];

                return GridTile(
                  key: ValueKey(data.id),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    title: Text(
                      data.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      children: [
                        Text(data.category),
                        Text(data.type),
                      ],
                    ),
                    trailing: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UpdateRecipe(index: index),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteRecipeAlert(context, index);
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            size: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (data.isVisible == true) {
                              setState(() {
                                setVisibility(index);
                              });
                            } else {
                              setState(() {
                                showAgain(index);
                              });
                            }
                          },
                          icon: (data.isVisible == true
                                  ? const Icon(
                                      Icons.visibility,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      size: 20,
                                    ) // add custom icons also
                              ),
                        ),
                      ],
                    ),
                  ),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => RecipeView(
                          passId: index,
                          passValue: data,
                        ),
                      ),
                    ),
                    child: Container(
                      height: 125,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          //<-- SEE HERE
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: 500,
                            child: Image.file(
                              File(data.image),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  deleteRecipeAlert(BuildContext context, index) {
    showDialog(
      context: context,
      builder: ((ctx) => AlertDialog(
            content: const Text('Really want to delete '),
            actions: [
              TextButton(
                onPressed: () {
                  deleteRecipe(index);
                  Navigator.of(context).pop(ctx);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(ctx),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          )),
    );
  }

  Future<void> setVisibility(int index) async {
    var recipeData = recipeBox.getAt(index);

    final recipeList = RecipeModel(
        category: recipeData!.category,
        description: recipeData.description,
        directions: recipeData.directions,
        ingrediants: recipeData.ingrediants,
        image: recipeData.image,
        servings: recipeData.servings,
        name: recipeData.name,
        type: recipeData.type,
        duration: recipeData.duration,
        isVisible: false);

    final recipeDB = await Hive.openBox<RecipeModel>('recipe');
    recipeDB.putAt(index, recipeList);
  }

  void showAgain(int index) async {
    var recipeData = recipeBox.getAt(index);

    final recipeList = RecipeModel(
        category: recipeData!.category,
        description: recipeData.description,
        directions: recipeData.directions,
        ingrediants: recipeData.ingrediants,
        image: recipeData.image,
        servings: recipeData.servings,
        name: recipeData.name,
        type: recipeData.type,
        duration: recipeData.duration,
        isVisible: true);

    final recipeDB = await Hive.openBox<RecipeModel>('recipe');
    recipeDB.putAt(index, recipeList);
  }
}
