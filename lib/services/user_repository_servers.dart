import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepositoryServers {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createFilesUser(
    String uid,
    String email,
    String userName,
    String phoneNumber,
    int lastUpdated,
  ) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection("INFO")
        .doc("user")
        .set({
          "id": uid,
          'email': email,
          'username': userName,
          'phoneNumber': phoneNumber,
          'lastUpdated': lastUpdated,
        });
  }
}
