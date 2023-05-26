import 'package:flutter/material.dart';
import 'package:prochef/commonscreens/ExploreScreen.dart';
import 'package:prochef/commonscreens/ProfileScreen.dart';
import 'package:prochef/commonscreens/feeds.dart';

import 'package:prochef/main.dart';
import 'package:prochef/widgets/drawer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  List page = [
    FeedsScreen(),
    ExploreScreen(),
    ProfileScreen(),
  ];

  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    print(LOGGED_USERNAME);
    return Scaffold(
      drawer: showDrawer(context),
      body: page.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black87,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: onTapIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.feed_outlined,
              color: Colors.black,
            ),
            label: 'Feeds',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  onTapIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Future<void> getUser() async {
  //   final _userNameShared = await SharedPreferences.getInstance();

  //   final _usernameLogged = _userNameShared.getString('username');

  //   LOGGED_USERNAME = _usernameLogged!;
  // }
}
