import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:insta_class/utils/app_colors.dart';

class DialogCustom {
  static void showErrorDialog(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      borderSide: const BorderSide(color: AppColors.accentGreen, width: 2),
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(20)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Error',
      desc: message,
      showCloseIcon: true,
      btnOkOnPress: () {},
    ).show();
  }

  static void showWrongDialog(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      borderSide: const BorderSide(color: AppColors.accentGreen, width: 2),
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(20)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Warning',
      desc: message,
      showCloseIcon: true,
      btnOkOnPress: () {},
    ).show();
  }

  static void showsuccessDialog(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      borderSide: const BorderSide(color: AppColors.accentGreen, width: 2),
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(20)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Success',
      desc: message,
      showCloseIcon: true,
      btnOkOnPress: () {},
    ).show();
  }
}
