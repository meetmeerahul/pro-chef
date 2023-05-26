import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:prochef/adminscreens/adminhome.dart';
import 'package:prochef/functions/dbComment.dart';
import 'package:prochef/main.dart';
import 'package:prochef/models/comment.dart';
import 'package:prochef/models/recipe.dart';
import 'package:prochef/userscreens/homescreen.dart';

class CommentScreen extends StatefulWidget {
  CommentScreen({
    Key? key,
    required this.passId,
    required this.passValue,
  }) : super(key: key);

  RecipeModel passValue;
  final int passId;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  get passId => widget.passId;

  get passValue => widget.passValue;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentController.text = "";
  }

  final TextEditingController _commentController = TextEditingController();

  late int id = widget.passId;

  @override
  Widget build(BuildContext context) {
    commentListNotifier.value.clear();
    getAllComments(recipeId: passId);
    return Scaffold(
        //drawer: showDrawer(context),
        appBar: AppBar(
          title: Text('Comments'),
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
        body: ValueListenableBuilder(
            valueListenable: commentListNotifier,
            builder: (BuildContext ctx, List<CommentModel> commentList,
                Widget? child) {
              if (commentList.length == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    'Nobody posted any comments on this recipe',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                );
              } else {
                return ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = commentList[index];

                    return ListTile(
                      title: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.username}  commented on ${data.commentTime} ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(data.comment),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: commentList.length,
                );
              }
            }),
        floatingActionButton: (USER_LOGGED_IN != 'admin'
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Add Comment'),
                        content: TextField(
                          controller: _commentController,
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: 'Enter your comment',
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              insertComment(
                                  comment: _commentController.text, index: id);
                              Navigator.of(context).pop(context);
                              commentAddSnackBar();
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(Icons.add_comment),
              )
            : Text('')));
  }

  insertComment({required int index, required String comment}) {
    final String _comment = comment;
    final String _user = LOGGED_USERNAME;
    final int _imageId = id;

    final _DateTime =
        " ${DateTime.now().day} - ${DateTime.now().month} - ${DateTime.now().year} ${DateTime.now().hour} : ${DateTime.now().minute}";

    final _commentInfo = CommentModel(
        username: _user,
        recipeId: _imageId,
        comment: _comment,
        commentTime: _DateTime);
    addComment(_commentInfo);
  }

  void commentAddSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueGrey,
        content: Text('Comment Posted'),
      ),
    );
  }
}
