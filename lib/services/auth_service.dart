import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_class/view_models/user_repository_view_model.dart';

class AuthService {
  final UserRepositoryViewModel _userRepositoryViewModel =
      UserRepositoryViewModel();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String? errorMessage;
  Future<String?> signUpAndSaveUser({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
    required int lastUpdated,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      _userRepositoryViewModel.CreateFilesUser(
        uid,
        email,
        userName,
        phoneNumber,
        lastUpdated,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "user-not-found";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      }
      return "Error";
    }
  }

  Future<String?> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      return null;
    } catch (e) {
      errorMessage = e.toString();
      return errorMessage;
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "لا يوجد مستخدم بهذا البريد الإلكتروني.";
      }
      return "حدث خطأ: ${e.message}";
    } catch (e) {
      return "خطأ غير متوقع: ${e.toString()}";
    }
  }

  Future<String?> sendVerificationEmail() async {
    try {
      User? user = _auth.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return null; 
      } else {
        return "المستخدم غير مسجل دخول أو البريد الإلكتروني مفعل بالفعل.";
      }
    } catch (e) {
      return "حدث خطأ أثناء إرسال البريد الإلكتروني: ${e.toString()}";
    }
  }

  Future<String> getUid() async {
    return _auth.currentUser!.uid;
  }
}
