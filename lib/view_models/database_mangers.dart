import 'package:flutter/material.dart';
import 'package:insta_class/models/database_helper.dart';
import 'package:insta_class/view_models/data_from_firestore_view_model.dart';
import 'package:provider/provider.dart';

class DatabaseMangers {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late DataFromFirestoreViewModel dataViewModel;

  Future<int> fetchDataAndStore(BuildContext context, String id) async {
    int add = 0;
    dataViewModel = Provider.of<DataFromFirestoreViewModel>(
      context,
      listen: false,
    );

    List<Map<String, dynamic>> firestoreData = await dataViewModel
        .getDataFromFirestore(id);

    for (var data in firestoreData) {
      add = await _databaseHelper.insert(
        data['id'],
        data['username'],
        data['email'],
        data['phoneNumber'],
        data['lastUpdated'] ?? DateTime.now().millisecondsSinceEpoch,
      );
    }
    return add;
  }

  Future<Map<String, dynamic>> fetchData(
    BuildContext context,
    String id,
  ) async {
    dataViewModel = Provider.of<DataFromFirestoreViewModel>(
      context,
      listen: false,
    );

    List<Map<String, dynamic>> firestoreData = await dataViewModel
        .getDataFromFirestore(id);
    return firestoreData.first;
  }

  Future<List<Map<String, dynamic>>> getData(
    String userId,
    BuildContext context,
  ) async {
    int? lastLocalUpdate = await _databaseHelper.getLastUpdatedTime();

    dataViewModel = Provider.of<DataFromFirestoreViewModel>(
      context,
      listen: false,
    );
    int lastFirestoreUpdate = await dataViewModel.getLastUpdatedTime(userId);

    if (lastLocalUpdate != null && lastFirestoreUpdate <= lastLocalUpdate) {
      return await _databaseHelper.getLocalData();
    }

    List<Map<String, dynamic>> firestoreData = await dataViewModel
        .getDataFromFirestore(userId);
    await _databaseHelper.clearData();
    await _databaseHelper.insertData(firestoreData);
    return firestoreData;
  }

  Future<List<Map<String, dynamic>>> getDaata() async {
    return await _databaseHelper.getLocalData();
  }

  Future<int> updateData(String id, String name) async {
    return await _databaseHelper.updatename(name, id);
  }
}
