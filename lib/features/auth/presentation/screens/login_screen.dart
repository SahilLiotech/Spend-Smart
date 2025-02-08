import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_smart/config/routes/routes.dart';
import 'package:spend_smart/core/utils/widgets/button_widget.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/custom_toast.dart';
import 'package:spend_smart/core/validator/email_validator.dart';
import 'package:spend_smart/core/validator/password_validator.dart';
import 'package:spend_smart/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/password_visiblity_cubit.dart';
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
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final textFieldWidth = width * 0.9;
    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
           CustomToast.showFailure(context, state.message);
          }
          if(state is LoginSuccess){
            CustomToast.showSuccess(context, "Login Successful");
            Navigator.pushNamed(context, Routes.dashboard);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
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
                    width: textFieldWidth,
                    focusNode: emailFocusNode,
                    nextFocusNode: passwordFocusNode,
                    validator: emailValidator,
                    textHeading: AppString.emailAddress,
                    labelText: AppString.enterEmailAddress,
                    controller: emailController,
                  ),
                  BlocBuilder<PasswordVisiblityCubit, bool>(
                    builder: (context, passwordHidden) {
                      return AuthTextFieldWidget(
                          width: textFieldWidth,
                          textHeading: AppString.password,
                          focusNode: passwordFocusNode,
                          validator: passwordValidator,
                          labelText: AppString.enterPassword,
                          controller: passwordController,
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
                              )));
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.forgetPassword);
                        },
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
                      isLoading: state is LoginLoading,
                      onTap: () {
                        
                        if (formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(
                                LoginSubmitted(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                      buttonWidth: textFieldWidth,
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
                        text: AppString.dontHaveAccount,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.blackColor,
                        fontSize: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.signup);
                        },
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
        },
      ),
    );
  }
}
