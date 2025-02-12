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
import 'package:spend_smart/features/auth/presentation/bloc/google_signin_bloc/google_signin_bloc.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = MediaQuery.sizeOf(context).width * 0.9;

    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      body: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                CustomToast.showFailure(
                    context, AppString.failure, state.message);
              }
              if (state is LoginSuccess) {
                CustomToast.showSuccess(
                    context, AppString.success, AppString.signUpSuccess);
                Navigator.pushNamed(context, Routes.dashboard);
              }
            },
          ),
          BlocListener<GoogleSigninBloc, GoogleSigninState>(
            listener: (context, state) {
              if (state is GoogleSigninSuccess) {
                CustomToast.showSuccess(
                    context, AppString.success, AppString.loginSuccess);
                Navigator.pushNamed(context, Routes.dashboard);
              } else if (state is GoogleSigninFailure) {
                CustomToast.showFailure(
                    context, AppString.failure, state.message);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingWidget(
                    title: AppString.login, subtitle: AppString.loginHeading),
                _buildEmailTextField(textFieldWidth),
                _buildPasswordTextField(textFieldWidth),
                _buildForgotPasswordLink(),
                _buildLoginButton(textFieldWidth),
                const Padding(
                    padding: EdgeInsets.all(8.0), child: OrDividerWidget()),
                _buildGoogleSignInButton(textFieldWidth),
                const SizedBox(height: 5),
                _buildSignUpRow(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField(double width) {
    return AuthTextFieldWidget(
      width: width,
      prefixIcon: Icon(Icons.email),
      focusNode: _emailFocusNode,
      nextFocusNode: _passwordFocusNode,
      validator: emailValidator,
      textHeading: AppString.emailAddress,
      labelText: AppString.enterEmailAddress,
      controller: _emailController,
    );
  }

  Widget _buildPasswordTextField(double width) {
    return BlocBuilder<PasswordVisibilityCubit, Map<String, bool>>(
      builder: (context, passwordHidden) {
        return AuthTextFieldWidget(
          width: width,
          prefixIcon: Icon(Icons.lock),
          textHeading: AppString.password,
          focusNode: _passwordFocusNode,
          validator: passwordValidator,
          labelText: AppString.enterPassword,
          controller: _passwordController,
          isPassword: passwordHidden['loginPassword']!,
          icon: IconButton(
            onPressed: () => context
                .read<PasswordVisibilityCubit>()
                .toggleLoginPasswordVisibility(),
            icon: Icon(passwordHidden['loginPassword']!
                ? Icons.visibility_off
                : Icons.visibility),
          ),
        );
      },
    );
  }

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, Routes.forgetPassword),
          child: CustomText(
            text: AppString.forgotPassword,
            color: CustomColors.blackColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(double width) {
    return Center(
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return ButtonWidget(
            isLoading: state is LoginLoading,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginSubmitted(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ));
              }
            },
            buttonWidth: width,
            buttonText: AppString.login,
            buttonRadius: 16,
          );
        },
      ),
    );
  }

  Widget _buildGoogleSignInButton(double width) {
    return Center(
      child: BlocBuilder<GoogleSigninBloc, GoogleSigninState>(
        builder: (context, state) {
          return GoogleButtonWidget(
            buttonRadius: 16,
            onTap: () =>
                context.read<GoogleSigninBloc>().add(GoogleSigninSubmitted()),
            width: width,
          );
        },
      ),
    );
  }

  Widget _buildSignUpRow() {
    return Row(
      spacing: 6,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: AppString.dontHaveAccount,
          fontWeight: FontWeight.w500,
          color: CustomColors.blackColor,
          fontSize: 16,
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, Routes.signup),
          child: CustomText(
            text: AppString.signUp,
            fontWeight: FontWeight.w500,
            color: CustomColors.primaryColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
