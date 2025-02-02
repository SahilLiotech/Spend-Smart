import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';

class GoogleButtonWidget extends StatelessWidget {
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final double borderRadius;
  final Color iconColor;
  final double width;
  final double height;

  const GoogleButtonWidget(
      {super.key,
      this.fontSize = 18,
      this.fontWeight = FontWeight.w500,
      this.fontColor = CustomColors.blackColor,
      this.borderRadius = 6,
      this.iconColor = CustomColors.whiteColor,
      this.width = 300,
      this.height = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: GoogleAuthButton(
        onPressed: () {},
        style: AuthButtonStyle(
            borderRadius: borderRadius,
            iconBackground: iconColor,
            buttonColor: CustomColors.whiteColor,
            buttonType: AuthButtonType.secondary,
            iconType: AuthIconType.secondary,
            textStyle: GoogleFonts.poppins(
              fontWeight: fontWeight,
              fontSize: fontSize,
              color: fontColor,
            )),
      ),
    );
  }
}
