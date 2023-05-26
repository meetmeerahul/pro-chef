//

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prochef/adminscreens/AlertsScreen.dart';
import 'package:prochef/adminscreens/uploadscreen.dart';
import 'package:prochef/commonscreens/ExploreScreen.dart';

import 'package:prochef/commonscreens/feeds.dart';

import 'package:prochef/models/alert.dart';
import 'package:prochef/widgets/drawer.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _selectedIndex = 0;

  int key = 0;

  List page = [
    FeedsScreen(),
    ExploreScreen(),
    UploadScreen(),
    AlertScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    testIfAlert();
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
        items: [
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
              Icons.upload,
              color: Colors.black,
            ),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              (key == 1 ? Icons.add_alert_sharp : Icons.add_alert_outlined),
              color: (key == 1 ? Colors.black : Colors.red[400]),
            ),
            label: 'Alerts',
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

  Future<void> testIfAlert() async {
    final alertBox = await Hive.openBox<AlertModel>('alert');

    var lst = alertBox.values.toList();

    if (lst.length == 0) {
      setState(() {
        key = 1;
      });
    } else {
      setState(() {
        key = 0;
      });
    }
  }
}
