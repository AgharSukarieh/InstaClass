import 'package:flutter/material.dart';
import 'package:insta_class/utils/app_colors.dart';
import 'package:insta_class/view_models/localization_view_model.dart';
import 'package:provider/provider.dart';

class EditTextPassword extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String imageicon;
  final bool isPassword;
  EditTextPassword({
    super.key,
    required this.controller,
    required this.labelText,
    required this.imageicon,
    required this.isPassword,
  });

  @override
  _EditTextPasswordState createState() => _EditTextPasswordState();
}

class _EditTextPasswordState extends State<EditTextPassword> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final LocalizationViewModel localizationVM =
        Provider.of<LocalizationViewModel>(context);
    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundEditText,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, 15)),
        ],
      ),
      child: TextFormField(
        obscureText: widget.isPassword ? _isObscured : false,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.backgroundEditText,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(40),
          ),
          hintText: widget.labelText,
          prefixIcon: Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(widget.imageicon, width: 18, height: 18),
          ),
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    icon: Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.Textgray,
                      ),
                    ),

                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  )
                  : null,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return localizationVM.translate("Please Enter Password");
          } else if (value.length < 6) {
            return localizationVM.translate("Your password less 6 ");
          }
          return null;
        },
      ),
    );
  }
}
