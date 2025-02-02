import 'package:flutter/material.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/custom_text_field_widget.dart';
import 'package:spend_smart/core/utils/custom_text_widget.dart';

class AuthTextFieldWidget extends StatelessWidget {
  final String textHeading;
  final String lableText;
  final double borderRadius;
  final bool isPassword;
  final Icon? icon;

  final TextEditingController controller;
  const AuthTextFieldWidget({
    super.key,
    required this.textHeading,
    required this.controller,
    this.lableText = "",
    this.borderRadius = 4.0,
    this.icon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: textHeading,
            color: CustomColors.blackColor,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
            labelText: lableText,
            isPassword: isPassword,
            controller: controller,
            borderRadius: borderRadius,
            icon: icon,
          )
        ],
      ),
    );
  }
}
