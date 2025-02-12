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
import 'package:spend_smart/features/auth/presentation/bloc/google_signin_bloc/google_signin_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/password_visiblity_cubit.dart';
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
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      body: MultiBlocListener(
        listeners: [
          BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpFailure) {
                CustomToast.showFailure(
                    context, AppString.failure, state.message);
              } else if (state is SignUpSuccess) {
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
                    title: AppString.signUp, subtitle: AppString.signupHeading),
                _buildTextField(
                    _userNameController,
                    _userNameFocusNode,
                    _emailFocusNode,
                    AppString.userName,
                    AppString.enterUserName,
                    Icon(Icons.person),
                    userNameValidator,
                    width),
                _buildTextField(
                    _emailController,
                    _emailFocusNode,
                    _passwordFocusNode,
                    AppString.emailAddress,
                    AppString.enterEmailAddress,
                    Icon(Icons.email),
                    emailValidator,
                    width),
                _buildPasswordTextField(width),
                _buildConfirmPasswordTextField(width),
                const SizedBox(height: 5),
                _buildSignupButton(width),
                const Padding(
                    padding: EdgeInsets.all(8.0), child: OrDividerWidget()),
                _buildGoogleSignInButton(width),
                const SizedBox(height: 1),
                _buildLoginRedirect(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      FocusNode focusNode,
      FocusNode? nextFocusNode,
      String heading,
      String label,
      Icon prefixIcon,
      String? Function(String?) validator,
      double width) {
    return AuthTextFieldWidget(
      width: width,
      textHeading: heading,
      focusNode: focusNode,
      nextFocusNode: nextFocusNode,
      labelText: label,
      prefixIcon: prefixIcon,
      controller: controller,
      validator: validator,
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
          isPassword: passwordHidden['password']!,
          icon: IconButton(
            onPressed: () => context
                .read<PasswordVisibilityCubit>()
                .togglePasswordVisibility(),
            icon: Icon(passwordHidden['password']!
                ? Icons.visibility_off
                : Icons.visibility),
          ),
        );
      },
    );
  }

  Widget _buildConfirmPasswordTextField(double width) {
    return BlocBuilder<PasswordVisibilityCubit, Map<String, bool>>(
      builder: (context, passwordHidden) {
        return AuthTextFieldWidget(
          width: width,
          prefixIcon: Icon(Icons.lock),
          textHeading: AppString.confirmPassword,
          focusNode: _confirmPasswordFocusNode,
          validator: (value) =>
              confirmPasswordValidator(value, _passwordController.text),
          labelText: AppString.enterPassword,
          controller: _confirmPasswordController,
          isPassword: passwordHidden['confirmPassword']!,
          icon: IconButton(
            onPressed: () => context
                .read<PasswordVisibilityCubit>()
                .toggleConfirmPasswordVisibility(),
            icon: Icon(passwordHidden['confirmPassword']!
                ? Icons.visibility_off
                : Icons.visibility),
          ),
        );
      },
    );
  }

  Widget _buildSignupButton(double width) {
    return Center(
      child: ButtonWidget(
        isLoading: context.watch<SignUpBloc>().state is SignUpLoading,
        onTap: () {
          if (_formKey.currentState!.validate()) {
            BlocProvider.of<SignUpBloc>(context).add(
              SignUpSubmitted(
                userName: _userNameController.text.trim(),
                email: _emailController.text.trim(),
                password: _passwordController.text,
              ),
            );
          }
        },
        buttonWidth: width,
        buttonText: AppString.signUp,
        buttonRadius: 16,
      ),
    );
  }

  Widget _buildGoogleSignInButton(double width) {
    return Center(
      child: BlocBuilder<GoogleSigninBloc, GoogleSigninState>(
        builder: (context, state) {
          return GoogleButtonWidget(
            // isLoading: state is GoogleSigninLoading,
            onTap: () =>
                context.read<GoogleSigninBloc>().add(GoogleSigninSubmitted()),
            width: width,
            buttonRadius: 16,
          );
        },
      ),
    );
  }

  Widget _buildLoginRedirect() {
    return Row(
      spacing: 6,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
            text: AppString.alreadyHaveAccount,
            fontWeight: FontWeight.w500,
            color: CustomColors.blackColor,
            fontSize: 16),
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, Routes.login),
          child: CustomText(
              text: AppString.login,
              fontWeight: FontWeight.w500,
              color: CustomColors.primaryColor,
              fontSize: 16),
        ),
      ],
    );
  }
}
