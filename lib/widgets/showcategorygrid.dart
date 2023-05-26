import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:prochef/commonscreens/viewrecipe.dart';
import 'package:prochef/functions/dbFav.dart';
import 'package:prochef/functions/dbRecipe.dart';

import 'package:prochef/models/favourite.dart';

import 'package:prochef/models/recipe.dart';

class ShowCategoryGrid extends StatefulWidget {
  ShowCategoryGrid({Key? key, required this.categoryChoosen}) : super(key: key);

  String categoryChoosen = '';

  @override
  State<ShowCategoryGrid> createState() => _ShowCategoryGridState();
}

class _ShowCategoryGridState extends State<ShowCategoryGrid> {
  String? get categoryChoosen => widget.categoryChoosen;
  late Box<RecipeModel> recipeBox;

  late Box<FavouriteModel> favBox;
  //late Box<FavouriteModel> favBox;

  int index = 0;

  @override
  void initState() {
    super.initState();

    recipeBox = Hive.box('recipe');
    favBox = Hive.box('favourite');

    //favBox = Hive.box('favourite');
  }

  @override
  Widget build(BuildContext context) {
    recipeCategoryNotifier.value.clear();
    //print(categoryChoosen);
    getRecipeByCategory(categoryChoosen!);
    print(categoryChoosen);
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: ValueListenableBuilder(
                valueListenable: recipeCategoryNotifier,
                builder: (BuildContext ctx, List<RecipeModel> recipeList,
                    Widget? child) {
                  if (recipeList.length != 0) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 500,
                              childAspectRatio: 1.2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 10),
                      itemCount: recipeList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        var data = recipeList[index];

                        if (data.isVisible == true) {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text("Category - ${data.category}"),
                                  Text("Type - ${data.type}"),
                                  Text("Cooking time - ${data.duration}"),
                                ],
                              ),
                              trailing: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    data.totalFav.toString(),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
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
                                height: 150,
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Image.file(
                                          File(data.image),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'No Recipes under this category',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                    );
                  }
                })));
  }

  bool getIfMadeFav({required int? id, required String loggedUsername}) {
    // print(id);
    final favouriteList = favBox.values
        .where((fav) => fav.recipeId == id && fav.username == loggedUsername)
        .toList();

    // print(favouriteList.length);

    if (favouriteList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  deleteFav({required int id, required String loggedUsername}) {
    delete(favid: id, loggedUsername: loggedUsername);
  }

  void setAsFav(
      {required int? id,
      required String loggedUsername,
      required String recipeName,
      required String recipeImgae}) {
    final fav = FavouriteModel(
        username: loggedUsername,
        recipeId: id!,
        recipeName: recipeName,
        image: recipeImgae);
    makeFav(fav);
  }

  Future<void> increaseFav({required RecipeModel data, required index}) async {
    int fav = 0;
    var recipe = await Hive.openBox<RecipeModel>('recipe');

    print(index);

    if (data.totalFav > 0) {
      fav = data.totalFav + 1;
    }

    final updatedRecipe = RecipeModel(
      name: data.name,
      category: data.category,
      type: data.type,
      image: data.image,
      servings: data.servings,
      ingrediants: data.ingrediants,
      directions: data.directions,
      description: data.description,
      duration: data.duration,
      isVisible: data.isVisible,
      totalFav: fav,
    );

    recipe.putAt(index, updatedRecipe);
  }

  Future<void> decreaseFav({required RecipeModel data, required index}) async {
    int fav = 0;

    var recipe = await Hive.openBox<RecipeModel>('recipe');

    if (data.totalFav == 0) {
      fav = 1;
    } else {
      fav++;
    }

    print(index);

    final updatedRecipe = RecipeModel(
      name: data.name,
      category: data.category,
      type: data.type,
      image: data.image,
      servings: data.servings,
      ingrediants: data.ingrediants,
      directions: data.directions,
      description: data.description,
      duration: data.duration,
      isVisible: data.isVisible,
      totalFav: fav,
    );

    recipe.putAt(index, updatedRecipe);
  }
}
