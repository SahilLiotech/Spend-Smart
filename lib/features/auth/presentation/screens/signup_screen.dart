import 'package:flutter/material.dart';
import 'package:spend_smart/core/utils/button_widget.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/custom_text_widget.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/features/auth/presentation/widget/auth_textfield_widget.dart';
import 'package:spend_smart/features/auth/presentation/widget/google_button.dart';
import 'package:spend_smart/features/auth/presentation/widget/heading_widget.dart';
import 'package:spend_smart/features/auth/presentation/widget/or_divider_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final textFieldWidth = width * 0.9;
    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            HeadingWidget(
              title: AppString.signUp,
              subtitle: AppString.signupHeading,
            ),
            SizedBox(height: 10),
            AuthTextFieldWidget(
              width: textFieldWidth,
              textHeading: AppString.userName,
              lableText: AppString.enterUserName,
              controller: userNameController,
            ),
            AuthTextFieldWidget(
              width: textFieldWidth,
              textHeading: AppString.emailAddress,
              lableText: AppString.enterEmailAddress,
              controller: emailController,
            ),
            AuthTextFieldWidget(
              width: textFieldWidth,
              textHeading: AppString.password,
              lableText: AppString.enterPassword,
              controller: passwordController,
              isPassword: true,
              icon: Icon(
                Icons.visibility,
              ),
            ),
            AuthTextFieldWidget(
              width: textFieldWidth,
              textHeading: AppString.confirmPassword,
              lableText: AppString.enterConfirmPassword,
              controller: confirmPasswordController,
              isPassword: true,
              icon: Icon(
                Icons.visibility,
              ),
            ),
            Center(
              child: ButtonWidget(
                onTap: () {},
                buttonWidth: textFieldWidth,
                buttonText: AppString.signUp,
                buttonRadius: 6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OrDividerWidget(),
            ),
            Center(
              child: GoogleButtonWidget(
                width: textFieldWidth,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 6,
              children: [
                CustomText(
                  text: AppString.alreadyHaveAccount,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.blackColor,
                  fontSize: 16,
                ),
                GestureDetector(
                  onTap: () {},
                  child: CustomText(
                    text: AppString.login,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
