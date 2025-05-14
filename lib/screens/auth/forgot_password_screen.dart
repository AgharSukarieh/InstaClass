import 'package:flutter/material.dart';
import 'package:insta_class/utils/app_colors.dart';
import 'package:insta_class/view_models/auth_viewmodel.dart';
import 'package:insta_class/view_models/localization_view_model.dart';
import 'package:insta_class/widgets/dialogCustom.dart';
import 'package:provider/provider.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _editingController = TextEditingController();
  GlobalKey<FormState> forforget = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final authsent = Provider.of<AuthViewmodel>(context);
    final localizationVM = Provider.of<LocalizationViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.background),
        ),
      ),
      body: Form(
        key: forforget,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizationVM.translate("Search Your Account"),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  localizationVM.translate(
                    "Enter your email address or username",
                  ),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {},
                  child: Text(
                    localizationVM.translate("Can't retrieve your password?"),
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return localizationVM.translate(
                        "Enter your email or username",
                      );
                    }
                    return null;
                  },
                  cursorColor: AppColors.primaryDark,
                  controller: _editingController,
                  style: TextStyle(color: AppColors.Textgray),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    labelText: localizationVM.translate(
                      "Email address or username",
                    ),
                    labelStyle: TextStyle(color: AppColors.primaryDark),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusColor: AppColors.primaryDark,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: AppColors.primaryDark),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  localizationVM.translate(
                    "You might receive notifications via WhatsApp or SMS for security and login purposes.",
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                Center(
                  child: MaterialButton(
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
                      if (forforget.currentState!.validate()) {
                        String? error = await authsent.resetPassword(
                          _editingController.text,
                        );
                        if (error == null) {
                          DialogCustom.showsuccessDialog(
                            context,
                            localizationVM.translate(
                              "Please check your inbox to verify your email.",
                            ),
                          );
                        } else {
                          DialogCustom.showErrorDialog(
                            context,
                            localizationVM.translate(
                              "Please Enter correct email.",
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      localizationVM.translate("Continue"),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
