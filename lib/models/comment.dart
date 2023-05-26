import 'package:hive_flutter/hive_flutter.dart';

part 'comment.g.dart';

@HiveType(typeId: 5)
class CommentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final int recipeId;

  @HiveField(3)
  final String comment;

  @HiveField(4)
  final String commentTime;

  CommentModel(
      {required this.username,
      required this.recipeId,
      this.id,
      required this.comment,
      required this.commentTime});
}
