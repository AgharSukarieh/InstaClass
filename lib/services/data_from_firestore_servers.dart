import 'package:cloud_firestore/cloud_firestore.dart';

class DataFromFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getDataFromFirestore(String id) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('users').doc(id).collection("INFO").get();
      List<Map<String, dynamic>> dataFromFirestore =
          querySnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
      return dataFromFirestore;
    } catch (error) {
      print("Error fetching data from Firestore: $error");
      return [];
    }
  }

  Future<int> getLastUpdatedTime(String id) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('users').doc(id).collection("INFO").get();
      List<int> times =
          querySnapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return data["lastUpdated"] as int? ?? 0;
          }).toList();
      return times.isNotEmpty ? times.reduce((a, b) => a > b ? a : b) : 0;
    } catch (error) {
      print("Error fetching lastUpdated from Firestore: $error");
      return 0;
    }
  }
}
