import 'package:flutter/material.dart';

import 'package:prochef/functions/dbRecipe.dart';
import 'package:prochef/funtions/getUser.dart';

import 'package:prochef/widgets/gridview.dart';
import 'package:prochef/widgets/search.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List type = ['Veg', 'Non-Veg'];

  late int typeKey = 0;

  @override
  Widget build(BuildContext context) {
    getUser();
    getAllRecipes();

    return Scaffold(
      //drawer: showDrawer(context),
      appBar:
          AppBar(toolbarHeight: 60, title: const Text('New Recipes'), actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => SearchScreen(),
              ));
            },
            icon: const Icon(Icons.search)),
      ]),
      body: ShowRecipeGrid(typeKey: typeKey),
    );
  }
}
