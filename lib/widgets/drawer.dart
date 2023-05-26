import 'package:flutter/material.dart';
import 'package:prochef/adminscreens/admincontrol.dart';
import 'package:prochef/commonscreens/about.dart';
import 'package:prochef/commonscreens/term.dart';
import 'package:prochef/functions/dbFav.dart';
import 'package:prochef/main.dart';
import 'package:prochef/userscreens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget showDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          child: Image.asset('assets/logo/prochef.png'),
        ),
        (USER_LOGGED_IN == 'admin'
            ? ListTile(
                leading: const Icon(
                  Icons.construction_outlined,
                ),
                title: const Text('Control Panel'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminControl()));
                },
              )
            : Text('')),
        ListTile(
          leading: const Icon(
            Icons.title_outlined,
          ),
          title: const Text('Term & Conditions'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TermsScreen()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.info_outline_rounded,
          ),
          title: const Text('About'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutScreen()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.logout_rounded,
          ),
          title: const Text('Signout'),
          onTap: () {
            signoutAlert(context);
          },
        ),
      ],
    ),
  );
}

Future<void> resetBool() async {
  final _SharePref = await SharedPreferences.getInstance();
  _SharePref.setBool('bool', false);
}

Future<void> resetAdminBool() async {
  final _SharePrefAdmin = await SharedPreferences.getInstance();
  _SharePrefAdmin.setBool('adminbool', false);
}

signoutAlert(BuildContext context) async {
  showDialog(
    context: context,
    builder: ((ctx) => AlertDialog(
          content: const Text('Are You Sure ?? '),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(ctx);
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                if (USER_LOGGED_IN == 'admin') {
                  resetAdminBool();
                } else {
                  resetBool();
                }

                USER_LOGGED_IN = '';

                favListNotifier.value.clear();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        )),
  );
}
