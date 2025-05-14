import 'package:flutter/material.dart';
import 'package:insta_class/utils/app_colors.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primaryDark,
        child: Column(
          children: [
            SizedBox(height: isLandscape ? 20 : 40),
            Image.asset(
              'images/app_logo.png',
              width: isLandscape ? 200 : 300,
              height: isLandscape ? 140 : 210,
            ),
            SizedBox(height: isLandscape ? 10 : 20),
            Expanded(
              child: Container(
                width: double.infinity,

                margin: EdgeInsets.only(top: isLandscape ? 20 : 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isLandscape ? 30 : 50),
                    topRight: Radius.circular(isLandscape ? 30 : 50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: isLandscape ? 100 : 170),
                      MaterialButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: isLandscape ? 80 : 110,
                          vertical: isLandscape ? 14 : 18,
                        ),
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            isLandscape ? 15 : 20,
                          ),
                        ),
                        color: AppColors.primaryDark,
                        onPressed: () {
                          Navigator.pushNamed(context, "/signup");
                        },
                        child: Text(
                          "Create an Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isLandscape ? 14 : 16,
                          ),
                        ),
                      ),
                      SizedBox(height: isLandscape ? 20 : 30),
                      MaterialButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: isLandscape ? 100 : 147,
                          vertical: isLandscape ? 14 : 18,
                        ),
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            isLandscape ? 15 : 20,
                          ),
                        ),
                        color: AppColors.accentGreen,
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isLandscape ? 14 : 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
