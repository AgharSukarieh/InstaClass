import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:insta_class/utils/app_colors.dart';
import 'package:insta_class/view_models/auth_viewmodel.dart';
import 'package:insta_class/view_models/localization_view_model.dart';
import 'package:insta_class/widgets/dialogCustom.dart';
import 'package:insta_class/widgets/edit_text_password.dart';
import 'package:insta_class/widgets/edit_text_styleInfo.dart';
import 'package:provider/provider.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _numPhone = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey();
  late String id;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final authViewModel = Provider.of<AuthViewmodel>(context);
    final localizationVM = Provider.of<LocalizationViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              Row(
                children: [
                  BackButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Image.asset(
                'images/image_gif/animation_say-hi.gif',
                width: 300,
                height: 160,
              ),
              SizedBox(height: 10),
              Text(
                localizationVM.translate("Create an Account"),

                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                localizationVM.translate(
                  "Please fill the form to create an account",
                ),
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    EditTextInfo(
                      controller: _userName,
                      labelText: localizationVM.translate(
                        "Enter your Full Name",
                      ),
                      imageicon: "images/icons/icon_user.png",
                    ),
                    const SizedBox(height: 10),
                    EditTextInfo(
                      controller: _email,
                      labelText: localizationVM.translate(
                        "Enter your Email Address",
                      ),
                      imageicon: "images/icons/icon_email.png",
                    ),
                    const SizedBox(height: 10),
                    EditTextPassword(
                      controller: _password,
                      labelText: localizationVM.translate(
                        "Enter your Password",
                      ),
                      imageicon: "images/icons/icon_unlock.png",
                      isPassword: true,
                    ),
                    const SizedBox(height: 10),
                    EditTextInfo(
                      controller: _numPhone,
                      labelText: localizationVM.translate(
                        "Enter your Phone Number",
                      ),
                      imageicon: "images/icons/icon_num_phone.png",
                    ),
                    const SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              localizationVM.translate(
                                "By signing up, you agree to our ",
                              ),
                              style: TextStyle(fontSize: 14),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                localizationVM.translate(
                                  "Terms and Conditions.",
                                ),
                                style: TextStyle(
                                  color: AppColors.customBlue,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    MaterialButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.39,
                        vertical: 15,
                      ),
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: AppColors.primaryDark,
                      onPressed: () async {
                        if (key.currentState!.validate()) {
                          final errory = await authViewModel.signUp(
                            _email.text,
                            _password.text,
                            _userName.text,
                            _numPhone.text,
                            DateTime.now().millisecondsSinceEpoch,
                          );
                          if (errory != null) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                              buttonsBorderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              dismissOnTouchOutside: true,
                              dismissOnBackKeyPress: false,
                              headerAnimationLoop: false,
                              animType: AnimType.bottomSlide,
                              title: 'Warning',
                              desc: localizationVM.translate(
                                "The email is incorrect or already in use.",
                              ),
                              showCloseIcon: true,
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          } else {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              "/home",
                              (route) => false,
                            );
                          }
                        } else {
                          DialogCustom.showErrorDialog(
                            context,
                            localizationVM.translate(
                              "The email is incorrect or already in use.",
                            ),
                          );
                        }
                      },
                      child:
                          authViewModel.isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                localizationVM.translate("Register"),
                                style: TextStyle(color: Colors.white),
                              ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          localizationVM.translate(
                            "You already have an account. ",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              "/login",
                              (route) => false,
                            );
                          },
                          child: Text(
                            localizationVM.translate("Log in."),
                            style: TextStyle(color: AppColors.customBlue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
