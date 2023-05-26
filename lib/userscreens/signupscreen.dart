import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prochef/functions/dbfunctions.dart';
import 'package:prochef/models/userModel.dart';
import 'package:prochef/userscreens/loginscreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late Box userBox;

  ImagePicker picker = ImagePicker();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _aboutController = TextEditingController();

  String? imagepath;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Hive.openBox<UserModel>('prochef');
    createBox();
  }

  void createBox() async {
    userBox = await Hive.openBox<UserModel>('prochef');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 10),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Form(
                            child: Column(
                              key: _formKey,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _usernameController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.person_2_rounded,
                                      color: Colors.grey,
                                    ),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Username",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Username is mandatory';
                                    } else if (value == 'Admin' ||
                                        value == 'ADMIN') {
                                      return 'Canot use this username ';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _passwordController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.password),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is mandatory';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[700]),
                                    ),
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: const Color(0xff4c505b),
                                      child: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            if (_usernameController
                                                    .text.isNotEmpty &&
                                                _passwordController
                                                    .text.isNotEmpty) {
                                              userAddSnackBar();

                                              onAddUserButtonClicked(context);

                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              const LoginScreen()),
                                                      (route) => false);
                                            } else {
                                              showSnackBar();
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ));
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Sign In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color.fromARGB(230, 10, 14, 14),
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onAddUserButtonClicked(BuildContext context) async {
    final uname = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (uname.isEmpty || password.isEmpty) {
      return;
    }

    final user = UserModel(
      username: uname,
      password: password,
    );

    createUser(user);
  }

  void checkIsEmpty(String s) {
    final String errMsg = s;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10.0),
        content: Text(errMsg),
      ),
    );
  }

  showSnackBar() {
    var errMsg = "";

    if (_usernameController.text.isEmpty &&
        _passwordController.text.isEmpty &&
        _aboutController.text.isEmpty) {
      errMsg = "Please Insert Valid Data In All Fields ";
    } else if (_usernameController.text == 'Admin' ||
        _usernameController.text == 'admin') {
      errMsg = "You canot be an admin";
    } else if (_usernameController.text.isEmpty) {
      errMsg = "username  Must Be Filled";
    } else if (_passwordController.text.isEmpty) {
      errMsg = "password  Must Be Filled";
    } else if (_aboutController.text.isEmpty) {
      errMsg = "About me Must Be Filled";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10.0),
        content: Text(errMsg),
      ),
    );
  }

  void userAddSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueGrey,
        content: Text('Your Account Has Been Created '),
      ),
    );
  }
}
