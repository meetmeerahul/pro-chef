import 'package:flutter/material.dart';

import 'package:prochef/main.dart';
import 'package:prochef/userscreens/changepassword.dart';
import 'package:prochef/userscreens/shoefavouites.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: showDrawer(context),
      appBar: AppBar(
        title: Text("${LOGGED_USERNAME}'s Profile"),
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
          Container(
            height: 447,
            width: double.infinity,
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ShowFavourites())),
                            child: Icon(
                              Icons.favorite_rounded,
                              size: 50,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Favourites')
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PasswordChange(),
                              ),
                            ),
                            child: Icon(
                              Icons.password_sharp,
                              size: 50,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Change Password')
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
