import 'package:flutter/material.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/custom_text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final double buttonTextSize;
  final Color backgroundColor;
  final Color fontColor;
  final double buttonWidth;
  final double buttonHeight;
  final double buttonRadius;

  const ButtonWidget(
      {super.key,
      required this.onTap,
      required this.buttonText,
      this.buttonTextSize = 18,
      this.backgroundColor = CustomColors.primaryColor,
      this.fontColor = CustomColors.whiteColor,
      this.buttonWidth = 200,
      this.buttonHeight = 50,
      this.buttonRadius = 12});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
        child: CustomText(
          text: buttonText,
          fontSize: buttonTextSize,
          color: fontColor,
        ),
      ),
    );
  }
}
