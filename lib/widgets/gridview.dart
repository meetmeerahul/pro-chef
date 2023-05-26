import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:prochef/commonscreens/viewrecipe.dart';
import 'package:prochef/functions/dbAlert.dart';

import 'package:prochef/functions/dbFav.dart';
import 'package:prochef/functions/dbRecipe.dart';
import 'package:prochef/main.dart';
import 'package:prochef/models/alert.dart';
import 'package:prochef/models/favourite.dart';

import 'package:prochef/models/recipe.dart';

class ShowRecipeGrid extends StatefulWidget {
  int typeKey;

  ShowRecipeGrid({Key? key, required this.typeKey}) : super(key: key);

  @override
  State<ShowRecipeGrid> createState() => _ShowRecipeGridState();
}

class _ShowRecipeGridState extends State<ShowRecipeGrid> {
  late Box<RecipeModel> recipeBox;

  late Box<FavouriteModel> favBox;
  late Box<AlertModel> alertBox;

  int index = 0;
  get typeKey => widget.typeKey;

  @override
  void initState() {
    super.initState();

    recipeBox = Hive.box('recipe');
    favBox = Hive.box('favourite');
    alertBox = Hive.box('alert');

    //favBox = Hive.box('favourite');
  }

  @override
  Widget build(BuildContext context) {
    getRecipe();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ValueListenableBuilder(
          valueListenable: recipeNotifier,
          builder:
              (BuildContext ctx, List<RecipeModel> recipeList, Widget? child) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10),
              itemCount: recipeList.length,
              itemBuilder: (BuildContext ctx, index) {
                final data = recipeList[index];

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
                          // IconButton(
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (_) => CommentScreen(
                          //           passId: index,
                          //           passValue: data,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   icon: (USER_LOGGED_IN != 'admin'
                          //       ? Icon(
                          //           Icons.comment,
                          //           size: 20,
                          //         )
                          //       : Icon(
                          //           Icons.comment,
                          //           size: 20,
                          //         )),
                          // ),
                          IconButton(
                            onPressed: () {
                              if (USER_LOGGED_IN != 'admin') {
                                if (getIfMadeFav(
                                    id: index,
                                    loggedUsername: LOGGED_USERNAME)) {
                                  setState(() {
                                    print("-------------");
                                    print(LOGGED_USERNAME);

                                    deleteFav(
                                        id: index,
                                        loggedUsername: LOGGED_USERNAME);

                                    decreaseFav(data: data, index: index);
                                  });
                                  favListNotifier.value.clear();
                                } else {
                                  setState(() {
                                    setAsFav(
                                        id: index,
                                        loggedUsername: LOGGED_USERNAME,
                                        recipeName: data.name,
                                        recipeImgae: data.image);

                                    increaseFav(data: data, index: index);
                                  });
                                }
                              }
                            },
                            icon: (USER_LOGGED_IN != 'admin'
                                ? ((getIfMadeFav(
                                        id: index,
                                        loggedUsername: LOGGED_USERNAME))
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        Icons.favorite_outline_outlined,
                                        color: Colors.red,
                                      ))
                                : Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )),
                          ),
                          Text(
                            data.totalFav.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
          },
        ),
      ),
    );
  }

  bool getIfMadeFav({required int? id, required String loggedUsername}) {
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
    deleteAlert(favid: id, loggedUsername: loggedUsername);
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

    final alert = AlertModel(
        username: loggedUsername,
        recipeId: id,
        image: recipeImgae,
        recipeName: recipeName);

    addToAlert(alert);
  }

  Future<void> increaseFav({required RecipeModel data, required index}) async {
    var recipe = await Hive.openBox<RecipeModel>('recipe');

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
      totalFav: data.totalFav + 1,
    );

    recipe.putAt(index, updatedRecipe);
  }

  Future<void> decreaseFav({required RecipeModel data, required index}) async {
    var recipe = await Hive.openBox<RecipeModel>('recipe');

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
      totalFav: data.totalFav - 1,
    );

    recipe.putAt(index, updatedRecipe);
  }
}
