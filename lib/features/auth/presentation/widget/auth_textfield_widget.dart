import 'package:flutter/material.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_field_widget.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';

class AuthTextFieldWidget extends StatelessWidget {
  final String textHeading;
  final String labelText;
  final double borderRadius;
  final bool isPassword;
  final IconButton? icon;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final FormFieldValidator<String>? validator;
  final Icon? prefixIcon;
  final double width;
  final TextEditingController controller;

  const AuthTextFieldWidget({
    super.key,
    required this.textHeading,
    required this.controller,
    this.labelText = "",
    this.borderRadius = 16.0,
    this.prefixIcon,
    this.icon,
    this.isPassword = false,
    this.focusNode,
    this.nextFocusNode,
    this.validator,
    this.width = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
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
              labelText: labelText,
              isPassword: isPassword,
              controller: controller,
              focusNode: focusNode,
              validator: validator,
              nextFocusNode: nextFocusNode,
              borderRadius: borderRadius,
              icon: icon,
              prefixIcon: prefixIcon,
            )
          ],
        ),
      ),
    );
  }
}
