import 'dart:io';

import 'package:flutter/material.dart';

import 'package:prochef/functions/dbFav.dart';
import 'package:prochef/models/favourite.dart';
import 'package:prochef/userscreens/viewrecipefromfav.dart';
import 'package:prochef/widgets/drawer.dart';

class ShowFavourites extends StatefulWidget {
  const ShowFavourites({super.key});

  @override
  State<ShowFavourites> createState() => _ShowFavouritesState();
}

class _ShowFavouritesState extends State<ShowFavourites> {
  @override
  Widget build(BuildContext context) {
    var data = getFav();

    return Scaffold(
      //drawer: showDrawer(context),
      appBar: AppBar(title: Text('Favoutites')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ValueListenableBuilder(
              valueListenable: favListNotifier,
              builder: (BuildContext ctx, List<FavouriteModel> favList,
                  Widget? child) {
                if (favList.length == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'You didnt made any recipe as favourite ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  );
                } else {
                  return ListView.separated(
                      itemBuilder: (ctx, index) {
                        final data = favList[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => ViewRecipeFromFav(
                                  index: data.recipeId,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                              title: Text(
                                data.recipeName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: ClipRRect(
                                child: Image(
                                  image: FileImage(File(data.image)),
                                ),
                              )),
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider();
                      },
                      itemCount: favList.length);
                }
              }),
        ),
      ),
    );
  }
}
