import 'package:flutter/material.dart';
import 'package:insta_class/utils/app_colors.dart';

// ignore: must_be_immutable
class ButtonStyleApp extends StatelessWidget {
  final String textButton;
  final String nextPage;
  late GlobalKey<FormState>? myKey;
  ButtonStyleApp({
    super.key,
    required this.textButton,
    required this.nextPage,
    this.myKey,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialButton(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.39,
        vertical: 15,
      ),
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: AppColors.primaryDark,
      onPressed: () {
        if (myKey!.currentState!.validate()) {
          Navigator.pushReplacementNamed(context, nextPage);
        }
      },
      child: Text(textButton, style: TextStyle(color: Colors.white)),
    );
  }
}
