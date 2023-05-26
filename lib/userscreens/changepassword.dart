import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:prochef/main.dart';
import 'package:prochef/models/userModel.dart';
import 'package:prochef/userscreens/loginscreen.dart';

import 'package:prochef/widgets/drawer.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(context),
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey[400],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/prochef.png',
                  height: 150,
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            height: 5,
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.password,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: const Color.fromRGBO(234, 236, 238, 2),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                hintText: 'New Password',
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _repeatController,
              buildCounter: (BuildContext context,
                      {required int currentLength,
                      int? maxLength,
                      bool? isFocused}) =>
                  null,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.password,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: const Color.fromRGBO(234, 236, 238, 2),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Repeat New Password',
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (_passwordController.text.isNotEmpty &&
                  _repeatController.text.isNotEmpty) {
                if (_passwordController.text != _repeatController.text) {
                  showNotSameError();

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const PasswordChange()),
                  );
                  return;
                }
                passwordUpdateSnackBar();

                onUpdateClicked(context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                    (route) => false);
              } else {
                showSnackBar();
              }
            },
            icon: const Icon(Icons.update),
            label: const Text('Update'),
          )
        ],
      ),
    );
  }

  showSnackBar() {
    var _errMsg = "";

    if (_passwordController.text.isEmpty && _repeatController.text.isEmpty) {
      _errMsg = "Please Insert Valid Data In All Fields ";
    } else if (_passwordController.text.isEmpty) {
      _errMsg = "Please Enter your new password";
    } else if (_repeatController.text.isEmpty) {
      _errMsg = "Please Repeat your password";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10.0),
        content: Text(_errMsg),
      ),
    );
  }

  void passwordUpdateSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.grey,
        content: Text('Your Password changed '),
      ),
    );
  }

  Future<void> onUpdateClicked(BuildContext context) async {
    var users = await Hive.openBox<UserModel>('prochef');

    var data = users.values.toList();

    int index = 0;

    for (var user in data) {
      if (user.username == LOGGED_USERNAME) {
        break;
      }
      index++;
    }

    final updatedUser = UserModel(
        username: LOGGED_USERNAME, password: _passwordController.text);

    users.putAt(index, updatedUser);
  }

  void showNotSameError() {
    final String _errMsg = "Password doesnt matches Repeat Password";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10.0),
        content: Text(_errMsg),
      ),
    );
  }
}
