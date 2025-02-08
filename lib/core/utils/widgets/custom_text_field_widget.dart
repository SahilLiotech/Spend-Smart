import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color hintTextColor;
  final String labelText;
  final Color borderColor;
  final double borderRadius;
  final bool isPassword;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final IconButton? icon;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.hintTextColor = CustomColors.hintTextColor,
    this.labelText = "",
    this.borderColor = CustomColors.primaryColor,
    this.borderRadius = 4,
    this.isPassword = false,
    this.focusNode,
    this.nextFocusNode,
    this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      focusNode: focusNode,
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        suffixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: GoogleFonts.poppins(
          color: hintTextColor,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        label: CustomText(
          text: labelText,
          color: CustomColors.hintTextColor,
        ),
      ),
    );
  }
}
