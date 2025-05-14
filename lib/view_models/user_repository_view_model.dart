import 'package:flutter/material.dart';
import 'package:insta_class/services/user_repository_servers.dart';

class UserRepositoryViewModel extends ChangeNotifier {
  final UserRepositoryServers _userRepository = UserRepositoryServers();
  Future CreateFilesUser(
    String uid,
    String email,
    String userName,
    String phoneNumber,
    int lastUpdated,
  ) async {
    await _userRepository.createFilesUser(
      uid,
      email,
      userName,
      phoneNumber,
      lastUpdated,
    );
  }
}
