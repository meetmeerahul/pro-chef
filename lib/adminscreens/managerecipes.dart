import 'package:flutter/material.dart';

import 'package:prochef/widgets/managerecipegrid.dart';

class ManageRecipes extends StatefulWidget {
  const ManageRecipes({super.key});

  @override
  State<ManageRecipes> createState() => _ManageRecipesState();
}

class _ManageRecipesState extends State<ManageRecipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: showDrawer(context),
      appBar: AppBar(title: const Text('Manage Recipes'), actions: const []),
      body: const ManageRecipeGrid(),
    );
  }
}
