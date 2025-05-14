import 'package:flutter/material.dart';
import 'package:insta_class/services/auth_service.dart';

class AuthViewmodel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoading = false;
  String? errorMessage;

  Future<String?> signUp(
    String email,
    String password,
    String userName,
    String phoneNumber,
    int lastUpdated,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      errorMessage = await _authService.signUpAndSaveUser(
        email: email,
        password: password,
        userName: userName,
        phoneNumber: phoneNumber,
        lastUpdated: DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();

    return errorMessage;
  }

  Future<String?> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      errorMessage = await _authService.login(email, password);
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
    return errorMessage;
  }

  Future<void> signout(BuildContext context) async {
    String? errorMessageout = await _authService.signOut(context);
    if (errorMessageout == null) {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (s) => false);
    }
  }

  Future<String?> resetPassword(String email) async {
    String? errormassagesed = await _authService.resetPassword(email);
    if (errormassagesed != null) {
      return "Your email invalid";
    } else {
      return null;
    }
  }

  Future<String?> verificationemail() async {
    String? errormassagesed = await _authService.sendVerificationEmail();
    if (errormassagesed != null) {
      return "Your email invalid";
    } else {
      return null;
    }
  }

  Future<String> getuid() async {
    return await _authService.getUid();
  }
}
