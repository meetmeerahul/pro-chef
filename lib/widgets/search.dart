import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prochef/commonscreens/viewrecipe.dart';
import 'package:prochef/models/recipe.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  List<RecipeModel> recipeList =
      Hive.box<RecipeModel>('recipe').values.toList();

  late List<RecipeModel> recipeDisplay = List<RecipeModel>.from(recipeList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: _searchController,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => goBack(context),
                  ),
                  filled: true,
                  fillColor: const Color.fromRGBO(234, 236, 238, 2),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                  hintText: 'search',
                ),
                onChanged: (value) {
                  _searchRecipe(value);
                },
              ),
              Expanded(
                child: recipeDisplay.isNotEmpty
                    ? ListView.builder(
                        itemCount: recipeDisplay.length,
                        itemBuilder: (context, index) {
                          File img = File(recipeDisplay[index].image);
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(img),
                            ),
                            title: Text(recipeDisplay[index].name),
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeView(
                                    passValue: recipeDisplay[index],
                                    passId: index,
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'No match found',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _searchRecipe(String value) {
    setState(() {
      recipeDisplay = recipeList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void goBack(BuildContext ctx) {
    Navigator.pop(context);
  }
}
