import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prochef/adminscreens/adminhome.dart';
import 'package:prochef/functions/dbAdmin.dart';
import 'package:prochef/functions/dbfunctions.dart';
import 'package:prochef/main.dart';
import 'package:prochef/models/adminModel.dart';
import 'package:prochef/models/userModel.dart';
import 'package:prochef/userscreens/homescreen.dart';
import 'package:prochef/userscreens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required String title});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Box<AdminModel> adminBox;

  late Box<UserModel> userBox;

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
    adminBox = Hive.box('admin');
    userBox = Hive.box('prochef');
    print(adminBox.values);
  }

  @override
  Widget build(BuildContext context) {
    if (adminBox.isEmpty) {
      addAdmin();
    }

    if (userBox.isEmpty) {
      addUser();
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.grey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/logo/prochef.png')],
        ),
      ),
    );
  }

  void addAdmin() {
    final admin = AdminModel(
      id: 0,
      username: 'admin',
      password: 'admin',
    );
    createAdmin(admin);
  }

  Future<void> gotoLogIn() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (cntxt) => const LoginScreen(),
      ),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final _sharefPrefs = await SharedPreferences.getInstance();

    final _userLoggedIn = _sharefPrefs.getBool('bool');

    final _adminShared = await SharedPreferences.getInstance();

    final _adminLogged = _adminShared.getBool('adminbool');

    final _userNameShared = await SharedPreferences.getInstance();

    final _usernameLogged = _userNameShared.getString('username');

    print(_usernameLogged);

    // if (_userLoggedIn == null ||
    //     _userLoggedIn == true ||
    //     _adminLogged == null ||
    //     _adminLogged == true)

    //      {

    if (_userLoggedIn == true) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => Homescreen()));
    } else if (_adminLogged == true) {
      USER_LOGGED_IN = 'admin';
      LOGGED_USERNAME = '';

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => AdminHome()));
    } 
    else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => LoginScreen()));
    }
  }

  void addUser() {
    final user = UserModel(
      id: 0,
      username: 'user',
      password: 'user',
    );
    createUser(user);
  }
}
