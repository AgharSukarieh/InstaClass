import 'package:flutter/material.dart';
import 'package:insta_class/utils/app_colors.dart';
import 'package:insta_class/view_models/auth_viewmodel.dart';
import 'package:insta_class/view_models/localization_view_model.dart';
import 'package:insta_class/widgets/dialogCustom.dart';
import 'package:insta_class/widgets/edit_text_password.dart';
import 'package:insta_class/widgets/edit_text_styleInfo.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> mykey = GlobalKey();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LocalizationViewModel localizationVM =
        Provider.of<LocalizationViewModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    final authViewModel = Provider.of<AuthViewmodel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: mykey,
          child: Container(
            color: AppColors.background,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'images/image_gif/animation_say-hi.gif',
                  width: 300,
                  height: 210,
                ),
                Text(
                  localizationVM.translate("Welcome back!"),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  localizationVM.translate("Please login to your account"),

                  style: TextStyle(fontSize: 14, color: AppColors.black),
                ),
                const SizedBox(height: 50),
                EditTextInfo(
                  controller: _emailController,
                  labelText: localizationVM.translate(
                    "Enter your Email Address",
                  ),
                  imageicon: "images/icons/icon_user.png",
                ),

                const SizedBox(height: 10),
                EditTextPassword(
                  controller: _passwordController,
                  labelText: localizationVM.translate("Enter your Password"),
                  imageicon: "images/icons/icon_unlock.png",
                  isPassword: true,
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/forgot");
                        },
                        child: Text(
                          localizationVM.translate("Forgot Password?"),
                          style: TextStyle(color: AppColors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                MaterialButton(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.39,
                    vertical: 17,
                  ),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: AppColors.primaryDark,
                  onPressed: () async {
                    if (mykey.currentState!.validate()) {
                      final errory = await authViewModel.login(
                        _emailController.text,
                        _passwordController.text,
                      );
                      if (errory != null) {
                        DialogCustom.showErrorDialog(
                          context,
                          localizationVM.translate(
                            "Your email or password not correct",
                          ),
                        );
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/home",
                          (rote) => false,
                        );
                      }
                    }
                  },
                  child:
                      authViewModel.isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                            localizationVM.translate("Login"),
                            style: TextStyle(color: Colors.white),
                          ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(localizationVM.translate("Don't have an account?")),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/signup",
                          (route) => true,
                        );
                      },
                      child: Text(
                        localizationVM.translate("Create a new one"),
                        style: TextStyle(color: AppColors.customBlue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 150),
                Text(
                  localizationVM.translate(
                    "© 2025 InstaClass\nAll rights reserved.",
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
