import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prochef/adminscreens/adminlogin.dart';
import 'package:prochef/main.dart';
import 'package:prochef/models/userModel.dart';
import 'package:prochef/userscreens/homescreen.dart';
import 'package:prochef/userscreens/signupscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    doCreateTheUserBox();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 140),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.35),
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
                                  style: TextStyle(color: Colors.black),
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
                                      'Sign in',
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[700]),
                                    ),
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Color(0xff4c505b),
                                      child: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            setBool();
                                            setUsername();
                                            if (_usernameController.text ==
                                                '') {
                                              checkIsEmpty('Username is Empty');
                                            } else if (_passwordController
                                                    .text ==
                                                '') {
                                              checkIsEmpty('Password is Empty');
                                            } else {
                                              onLoginClick();

                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Homescreen(),
                                                      ),
                                                      (route) => false);
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
                            height: 20,
                          ),
                          const SizedBox(
                            height: 160,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                hoverColor: Colors.amber,
                                child: const Text(
                                  'Signup ',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => const AdminLogin(),
                                    ));
                                  },
                                  child: const Text(
                                    'Login as admin',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
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

  void checkIsEmpty(String s) {
    final String _errMsg = s;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10.0),
        content: Text(_errMsg),
      ),
    );
  }

  bool onLoginClick() {
    final username = _usernameController.text.trim();
    final passWord = _passwordController.text.trim();
    LOGGED_USERNAME = _usernameController.text.trim();

    final userLogin = Hive.box<UserModel>('prochef');

    var user = userLogin.values.firstWhere(
      (element) => element.username == username && element.password == passWord,
      orElse: () => invalid(),
    );

    return true;
  }

  invalid() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: const Text(
          'Invalid Username and Password',
          style: TextStyle(fontSize: 18),
        )));
  }

  Future<void> setBool() async {
    final _SharePref = await SharedPreferences.getInstance();
    _SharePref.setBool('bool', true);
  }

  Future<void> setUsername() async {
    final _sharePrefUsername = await SharedPreferences.getInstance();
    _sharePrefUsername.setString('username', LOGGED_USERNAME);
  }

  Future<void> doCreateTheUserBox() async {
    if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
      Hive.registerAdapter(UserModelAdapter());
    }

    await Hive.openBox<UserModel>('prochef');
  }
}
