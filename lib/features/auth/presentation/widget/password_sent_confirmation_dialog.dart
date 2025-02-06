import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/button_widget.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/features/auth/presentation/widget/or_divider_widget.dart';

class ResetPassWordConfirmationDialog extends StatelessWidget {
  final VoidCallback onResendEmail;
  final VoidCallback onBackToLogin;

  const ResetPassWordConfirmationDialog({
    super.key,
    required this.onResendEmail,
    required this.onBackToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/email_icon.svg', // Ensure the SVG file is in the correct path
              height: 50,
            ),
            CustomText(
              text: AppString.linkSentToEmail,
              textAlign: TextAlign.center,
              color: CustomColors.blackColor,
            ),
            ButtonWidget(
              onTap: onResendEmail,
              buttonText: AppString.resendEmail,
            ),
            OrDividerWidget(),
            ButtonWidget(
              onTap: onBackToLogin,
              buttonText: AppString.backToLogin,
              backgroundColor: CustomColors.whiteColor,
              fontColor: CustomColors.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}
