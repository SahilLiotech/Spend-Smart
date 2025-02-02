import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/features/auth/presentation/widget/auth_textfield_widget.dart';
import 'package:spend_smart/features/auth/presentation/widget/heading_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          HeadingWidget(
            title: AppString.login,
            subtitle: AppString.loginHeading,
          ),
          SizedBox(height: 20),
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
        ],
      ),
    );
  }
}
