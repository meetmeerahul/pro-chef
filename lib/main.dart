import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prochef/models/adminModel.dart';
import 'package:prochef/models/alert.dart';
import 'package:prochef/models/comment.dart';
import 'package:prochef/models/favourite.dart';
import 'package:prochef/models/recipe.dart';
import 'package:prochef/models/userModel.dart';

import 'package:prochef/userscreens/splashscreen.dart';

var USER_LOGGED_IN = "";

String LOGGED_USERNAME = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(AdminModelAdapter().typeId)) {
    Hive.registerAdapter(AdminModelAdapter());
  }

  await Hive.openBox<AdminModel>('admin');

  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }

  await Hive.openBox<UserModel>('prochef');

  if (!Hive.isAdapterRegistered(RecipeModelAdapter().typeId)) {
    Hive.registerAdapter(RecipeModelAdapter());
  }
  await Hive.openBox<RecipeModel>('recipe');

  if (!Hive.isAdapterRegistered(FavouriteModelAdapter().typeId)) {
    Hive.registerAdapter(FavouriteModelAdapter());
  }
  await Hive.openBox<FavouriteModel>('favourite');

  if (!Hive.isAdapterRegistered(CommentModelAdapter().typeId)) {
    Hive.registerAdapter(CommentModelAdapter());
  }
  await Hive.openBox<CommentModel>('comment');

  if (!Hive.isAdapterRegistered(AlertModelAdapter().typeId)) {
    Hive.registerAdapter(AlertModelAdapter());
  }
  await Hive.openBox<AlertModel>('alert');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProChef',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SplashScreen(title: 'Welcome'),
    );
  }
}
