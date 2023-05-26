import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prochef/funtions/getUser.dart';
import 'package:prochef/main.dart';
import 'package:prochef/models/favourite.dart';

ValueNotifier<List<FavouriteModel>> favListNotifier = ValueNotifier([]);

Future<void> makeFav(FavouriteModel value) async {
  print(' logged as ${value.username}');
  final favBox = await Hive.openBox<FavouriteModel>('favourite');
  await favBox.add(value);
}

Future<void> delete(
    {required int favid, required String loggedUsername}) async {
  final favBox = await Hive.openBox<FavouriteModel>('favourite');

  final value2 = loggedUsername;
  print(value2);
  final records = favBox.values.toList();
  print("Length is ${records.length}");
// Filter the list based on the two values
  int count = 0;
  for (var item in records) {
    if (item.recipeId == favid && item.username == loggedUsername) {
      favBox.deleteAt(count);
      break;
    }
    count++;
  }
}

Future<void> getFav() async {
  final favBox = await Hive.openBox<FavouriteModel>('favourite');

  final data = favBox.values.toList();
  getUser();

  print(LOGGED_USERNAME);
  favListNotifier.value.clear();
  for (var fav in data) {
    if (fav.username == LOGGED_USERNAME) {
      favListNotifier.value.add(fav);
      favListNotifier.notifyListeners();
    }
  }
}

Future<void> deleteFav(int id) async {
  final favBox = await Hive.openBox<FavouriteModel>('favourite');

  final data = favBox.values.toList();

  //favBox.delete(favwhere((element) => element.recipeId==id))

  int index = 0;
  for (var fav in data) {
    if (fav.recipeId == id) {
      favBox.deleteAt(index);
    }
    index++;
  }
}
