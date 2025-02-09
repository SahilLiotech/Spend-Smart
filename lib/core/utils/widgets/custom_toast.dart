import 'package:flutter/material.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static void showSuccess(BuildContext context, String? title, String message) {
    toastification.show(
      context: context,
      title: CustomText(
        text: title!,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      description: CustomText(
        text: message,
        color: Colors.black,
        fontSize: 14,
      ),
      autoCloseDuration: Duration(seconds: 3),
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      alignment: Alignment.bottomCenter,
    );
  }

  static void showFailure(BuildContext context, String? title, String message) {
    toastification.show(
      context: context,
      title: CustomText(
        text: title!,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      description: CustomText(
        text: message,
        color: Colors.black,
        fontSize: 14,
      ),
      autoCloseDuration: Duration(seconds: 3),
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      alignment: Alignment.bottomCenter,
    );
  }
}
