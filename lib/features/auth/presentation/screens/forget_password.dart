import 'package:flutter/material.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/button_widget.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/features/auth/presentation/widget/auth_textfield_widget.dart';
import 'package:spend_smart/features/auth/presentation/widget/heading_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController resetPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    resetPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: CustomColors.whiteColor,
            child: IconButton(
              icon:
                  const Icon(Icons.arrow_back, color: CustomColors.blackColor),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LottieHeadingWidget(
              lottieAsset: "assets/images/forget_password_lottie.json",
            ),
            const SizedBox(height: 10),
            CustomText(
              text: AppString.forgetPasswordHeading,
              color: CustomColors.blackColor,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            AuthTextFieldWidget(
              textHeading: AppString.emailAddress,
              controller: resetPasswordController,
              lableText: AppString.enterEmailAddress,
              width: MediaQuery.sizeOf(context).width * 0.9,
            ),
            ButtonWidget(
              onTap: () {},
              buttonText: AppString.resetPassword,
            ),
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: CustomText(
                  text: AppString.backToLogin,
                  color: CustomColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                )),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
