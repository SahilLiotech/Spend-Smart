import 'package:flutter/material.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static void showSuccess(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(message),
      autoCloseDuration: Duration(seconds: 2),
      backgroundColor: CustomColors.incomeColor,
      foregroundColor: CustomColors.whiteColor,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      alignment: Alignment.bottomCenter,
    );
  }

  static void showFailure(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(message),
      autoCloseDuration: Duration(seconds: 2),
      backgroundColor: CustomColors.expenseColor,
      foregroundColor: CustomColors.whiteColor,
      type: ToastificationType.error,
      alignment: Alignment.bottomCenter,
    );
  }
}
