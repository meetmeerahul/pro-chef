import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:prochef/adminscreens/adminhome.dart';
import 'package:prochef/commonscreens/commentscreen.dart';
import 'package:prochef/functions/dbFav.dart';
import 'package:prochef/main.dart';
import 'package:prochef/models/favourite.dart';
import 'package:prochef/models/recipe.dart';
import 'package:prochef/userscreens/homescreen.dart';
import 'package:prochef/widgets/drawer.dart';

class RecipeView extends StatefulWidget {
  RecipeView({
    Key? key,
    required this.passValue,
    required this.passId,
  }) : super(key: key);

  RecipeModel passValue;
  final int passId;

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late Box<FavouriteModel> favBox;
  @override
  void initState() {
    super.initState();
    favBox = Hive.box('favourite');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(context),
      appBar: AppBar(
        title: Text(widget.passValue.name),
        leading: IconButton(
            icon: const Icon(Icons.arrow_circle_left_sharp),
            onPressed: () {
              (USER_LOGGED_IN == 'admin'
                  ? Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => const AdminHome()),
                      (route) => false)
                  : Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => const Homescreen()),
                      (route) => false));
            }),
      ),
      body: ListView(
        children: <Widget>[
          itemImage(),
          content(context: context),
        ],
      ),
    );
  }

  Widget itemImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(
                //<-- SEE HERE
                width: 2,
              ),
            ),
            child: Image.file(
              File(widget.passValue.image),
            ),
          )
        ],
      ),
    );
  }

  Widget content({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 5, 8, 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              Text(
                "${widget.passValue.totalFav}",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CommentScreen(
                          passId: widget.passId,
                          passValue: widget.passValue,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.comment,
                    size: 20,
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Recipe Name : ${widget.passValue.name}",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Category : ${widget.passValue.category}",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Recipe Type : ${widget.passValue.type}",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Cooking Duration : ${widget.passValue.duration}",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Servings For : ${widget.passValue.servings}",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Ingrediants : ${widget.passValue.ingrediants}",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Discription : ${widget.passValue.description}",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Directions : ${widget.passValue.directions}",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
        ],
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
