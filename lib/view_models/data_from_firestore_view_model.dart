import 'package:flutter/material.dart';
import 'package:insta_class/services/data_from_firestore_servers.dart';

class DataFromFirestoreViewModel extends ChangeNotifier {
  final DataFromFirestoreService _dataFromFirestoreService =
      DataFromFirestoreService();
  List<Map<String, dynamic>> dataFromFirestore = [];

  Future<List<Map<String, dynamic>>> getDataFromFirestore(String id) async {
    try {
      dataFromFirestore = await _dataFromFirestoreService.getDataFromFirestore(
        id,
      );
      notifyListeners();
      return dataFromFirestore;
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  Future<int> getLastUpdatedTime(String id) async {
    return await _dataFromFirestoreService.getLastUpdatedTime(id);
  }
}
