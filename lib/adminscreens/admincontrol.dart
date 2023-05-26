import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:prochef/adminscreens/managerecipes.dart';
import 'package:prochef/adminscreens/uploadscreen.dart';

class AdminControl extends StatefulWidget {
  const AdminControl({super.key});

  @override
  State<AdminControl> createState() => _AdminControlState();
}

class _AdminControlState extends State<AdminControl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control panel'),
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
            height: 500,
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
                                        const ManageRecipes())),
                            child: Icon(
                              Icons.settings,
                              size: 50,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Manage')
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: const [
                          SizedBox(
                            height: 5,
                          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UploadScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
