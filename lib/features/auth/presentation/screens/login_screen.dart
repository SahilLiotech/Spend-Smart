import 'package:flutter/material.dart';
import 'package:spend_smart/core/utils/button_widget.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/custom_text_widget.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/features/auth/presentation/widget/auth_textfield_widget.dart';
import 'package:spend_smart/features/auth/presentation/widget/google_button.dart';
import 'package:spend_smart/features/auth/presentation/widget/heading_widget.dart';
import 'package:spend_smart/features/auth/presentation/widget/or_divider_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            HeadingWidget(
              title: AppString.login,
              subtitle: AppString.loginHeading,
            ),
            SizedBox(height: 10),
            AuthTextFieldWidget(
              textHeading: AppString.emailAddress,
              lableText: AppString.enterEmailAddress,
              controller: emailController,
            ),
            AuthTextFieldWidget(
              textHeading: AppString.password,
              lableText: AppString.enterPassword,
              controller: passwordController,
              isPassword: true,
              icon: Icon(
                Icons.visibility,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: CustomText(
                    text: AppString.forgotPassword,
                    color: CustomColors.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: ButtonWidget(
                onTap: () {},
                buttonWidth: MediaQuery.sizeOf(context).width * 0.9,
                buttonText: AppString.login,
                buttonRadius: 6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OrDividerWidget(),
            ),
            Center(
              child: GoogleButtonWidget(
                width: MediaQuery.sizeOf(context).width * 0.9,
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
                  text: AppString.dontHaveAccount,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.blackColor,
                  fontSize: 16,
                ),
                GestureDetector(
                  onTap: () {},
                  child: CustomText(
                    text: AppString.signUp,
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
