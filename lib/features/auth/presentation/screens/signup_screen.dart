import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_smart/config/routes/routes.dart';
import 'package:spend_smart/core/utils/widgets/button_widget.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/custom_toast.dart';
import 'package:spend_smart/core/validator/confirm_password_validator.dart';
import 'package:spend_smart/core/validator/email_validator.dart';
import 'package:spend_smart/core/validator/password_validator.dart';
import 'package:spend_smart/core/validator/username_validator.dart';
import 'package:spend_smart/features/auth/presentation/bloc/password_visiblity_cubit.dart';
import 'package:spend_smart/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    userNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Build");
    final width = MediaQuery.sizeOf(context).width;
    final textFieldWidth = width * 0.9;
    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
          CustomToast.showFailure(context, state.message);
          }
          if (state is SignUpSuccess) {
            CustomToast.showSuccess(context, "Sign Up Successful");
            Navigator.pushNamed(context, Routes.dashboard);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  HeadingWidget(
                    title: AppString.signUp,
                    subtitle: AppString.signupHeading,
                  ),
                  SizedBox(height: 5),
                  AuthTextFieldWidget(
                    width: textFieldWidth,
                    textHeading: AppString.userName,
                    focusNode: userNameFocusNode,
                    nextFocusNode: emailFocusNode,
                    labelText: AppString.enterUserName,
                    controller: userNameController,
                    validator: userNameValidator,
                  ),
                  AuthTextFieldWidget(
                    width: textFieldWidth,
                    textHeading: AppString.emailAddress,
                    focusNode: emailFocusNode,
                    nextFocusNode: passwordFocusNode,
                    labelText: AppString.enterEmailAddress,
                    controller: emailController,
                    validator: emailValidator,
                  ),
                  BlocBuilder<PasswordVisiblityCubit, bool>(
                    builder: (context, passwordHidden) {
                      return AuthTextFieldWidget(
                        width: textFieldWidth,
                        textHeading: AppString.password,
                        labelText: AppString.enterPassword,
                        focusNode: passwordFocusNode,
                        nextFocusNode: confirmPasswordFocusNode,
                        controller: passwordController,
                        validator: passwordValidator,
                        isPassword: passwordHidden ? true : false,
                        icon: IconButton(
                          onPressed: () {
                            context
                                .read<PasswordVisiblityCubit>()
                                .toggleVisibility();
                          },
                          icon: Icon(
                            passwordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<PasswordVisiblityCubit, bool>(
                    builder: (context, passwordHidden) {
                      return AuthTextFieldWidget(
                        width: textFieldWidth,
                        textHeading: AppString.confirmPassword,
                        labelText: AppString.enterConfirmPassword,
                        focusNode: confirmPasswordFocusNode,
                        controller: confirmPasswordController,
                        isPassword: passwordHidden ? true : false,
                        validator: (value) => confirmPasswordValidator(
                            value, passwordController.text),
                        icon: IconButton(
                          onPressed: () {
                            context
                                .read<PasswordVisiblityCubit>()
                                .toggleVisibility();
                          },
                          icon: Icon(
                            passwordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: ButtonWidget(
                      isLoading: state is SignUpLoading,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SignUpBloc>(context).add(
                            SignUpSubmitted(
                              userName: userNameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
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
                        onTap: () {
                          Navigator.pushNamed(context, Routes.login);
                        },
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
        },
      ),
    );
  }
}
