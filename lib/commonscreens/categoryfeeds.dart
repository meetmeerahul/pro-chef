import 'package:flutter/material.dart';



import 'package:prochef/widgets/showcategorygrid.dart';

class CategoryFeeds extends StatefulWidget {
  CategoryFeeds({super.key, required this.categoryChoosen});
  String categoryChoosen = '';

  @override
  State<CategoryFeeds> createState() => _CategoryFeedsState();
}

class _CategoryFeedsState extends State<CategoryFeeds> {
  String? get categoryChoosen => widget.categoryChoosen;

  @override
  Widget build(BuildContext context) {
    print(categoryChoosen);
    print(categoryChoosen.runtimeType);
    return Scaffold(
      //drawer: showDrawer(context),
      appBar: AppBar(title: const Text('Feeds Screen')),
      body: ShowCategoryGrid(categoryChoosen: categoryChoosen!),
    );
  }
}
