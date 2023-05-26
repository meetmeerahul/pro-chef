import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prochef/models/comment.dart';

ValueNotifier<List<CommentModel>> commentListNotifier = ValueNotifier([]);

Future<void> addComment(CommentModel value) async {
  final commentDB = await Hive.openBox<CommentModel>('comment');

 await commentDB.add(value);

  getAllComments(recipeId: value.recipeId);
}

Future<void> getAllComments({required int recipeId}) async {
  commentListNotifier.value.clear();
  final commentDB = await Hive.openBox<CommentModel>('comment');

  final data = commentDB.values.toList();
  print(data.length);
  commentListNotifier.value.clear();

  for (var comment in data) {
    if (comment.recipeId == recipeId) {
      commentListNotifier.value.add(comment);
      commentListNotifier.notifyListeners();
    }
  }
}

Future<void> deleteComment(int recipeID) async {
  final commentDB = await Hive.openBox<CommentModel>('comment');

  final data = commentDB.values.toList();
  int index = 0;

  for (var comment in data) {
    if (comment.recipeId == recipeID) {
      commentDB.deleteAt(index);
      index++;
    }
  }
}

Future<void> deleteAllComment() async {
  final commentDB = await Hive.openBox<CommentModel>('comment');
  commentDB.deleteAll(commentDB.values);
}



