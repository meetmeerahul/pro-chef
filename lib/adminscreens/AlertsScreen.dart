import 'dart:io';

import 'package:flutter/material.dart';

import 'package:prochef/functions/dbAlert.dart';
import 'package:prochef/models/alert.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  @override
  Widget build(BuildContext context) {
    getAlert();
    return Scaffold(
      //drawer: showDrawer(context),
      appBar: AppBar(title: const Text('Alerts Screen')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ValueListenableBuilder(
            valueListenable: alertnotifier,
            builder:
                (BuildContext ctx, List<AlertModel> alertList, Widget? child) {
              if (alertList.isNotEmpty) {
                return ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = alertList[index];

                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            data.username,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'made',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            data.recipeName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'as fav',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      onTap: () {},
                      leading: Image(image: FileImage(File(data.image))),
                      trailing: FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    deleteAlertFromAlert(alertId: index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: alertList.length,
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'No New Alerts !!!',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
