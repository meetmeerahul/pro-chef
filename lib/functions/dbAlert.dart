import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:prochef/models/alert.dart';

ValueNotifier<List<AlertModel>> alertnotifier = ValueNotifier([]);

Future<void> addToAlert(AlertModel alert) async {
  print('Add alert invocked');
  final alertBox = await Hive.openBox<AlertModel>('alert');
  final _id = await alertBox.add(alert);
}

Future<void> deleteAlert(
    {required int favid, required String loggedUsername}) async {
  print('Delete alert invocked');
  final alertBox = await Hive.openBox<AlertModel>('alert');

  final records = alertBox.values.toList();

  int count = 0;
  for (var item in records) {
    if (item.recipeId == favid) {
      alertBox.deleteAt(count);
      break;
    }
    count++;
  }
}

Future<void> getAlert() async {
  final alertBox = await Hive.openBox<AlertModel>('alert');

  final data = alertBox.values.toList();

  alertnotifier.value.clear();

  if (data.length == 0) {
    alertnotifier.value.clear();
  } else {
    for (var alert in data) {
      alertnotifier.value.add(alert);
      alertnotifier.notifyListeners();
    }
  }
}

Future<void> deleteAlertFromAlert({required int alertId}) async {
  print("alert id is $alertId");

  final alertBox = await Hive.openBox<AlertModel>('alert');
  alertBox.deleteAt(alertId);
  getAlert();
}

Future<void> testIfAlert() async {
  final alertBox = await Hive.openBox<AlertModel>('alert');

  var lst = alertBox.values.toList();

  if (lst.isEmpty) {
    {}
  }
}
