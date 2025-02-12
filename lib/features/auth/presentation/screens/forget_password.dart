import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_smart/config/routes/routes.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/button_widget.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/core/utils/widgets/custom_toast.dart';
import 'package:spend_smart/core/validator/email_validator.dart';
import 'package:spend_smart/features/auth/presentation/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:spend_smart/features/auth/presentation/widget/auth_textfield_widget.dart';
import 'package:spend_smart/features/auth/presentation/widget/lottie_heading_widet.dart';
import 'package:spend_smart/features/auth/presentation/widget/or_divider_widget.dart';
import 'package:spend_smart/features/auth/presentation/widget/password_sent_confirmation_dialog.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onResetPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ForgetPasswordBloc>().add(
            ForgetPasswordSubmitted(email: _emailController.text),
          );
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ResetPassWordConfirmationDialog(
        onResendEmail: () => _onResetPassword(context),
        onBackToLogin: () =>
            Navigator.pushReplacementNamed(context, Routes.login),
      ),
    );
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
      body: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccess) {
            _showSuccessDialog(context);
          } else if (state is ForgetPasswordFailure) {
            CustomToast.showFailure(context, AppString.failure, state.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LottieHeadingWidget(
                      lottieAsset: "assets/lottie/forget_password_lottie.json"),
                  const SizedBox(height: 10),
                  _buildHeadingText(),
                  const SizedBox(height: 5),
                  _buildEmailTextField(),
                  const SizedBox(height: 5),
                  _buildResetPasswordButton(state),
                  _buildOrDivider(),
                  _buildBackToLoginButton(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeadingText() {
    return CustomText(
      text: AppString.forgetPasswordHeading,
      color: CustomColors.blackColor,
      fontWeight: FontWeight.w700,
      fontSize: 18,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEmailTextField() {
    return AuthTextFieldWidget(
      textHeading: AppString.emailAddress,
      validator: emailValidator,
      controller: _emailController,
      prefixIcon: const Icon(Icons.email),
      labelText: AppString.enterEmailAddress,
      width: MediaQuery.sizeOf(context).width * 0.9,
    );
  }

  Widget _buildResetPasswordButton(ForgetPasswordState state) {
    return ButtonWidget(
      isLoading: state is ForgetPasswordLoading,
      onTap: () => _onResetPassword(context),
      buttonText: AppString.resetPassword,
    );
  }

  Widget _buildOrDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: OrDividerWidget(),
    );
  }

  Widget _buildBackToLoginButton() {
    return ButtonWidget(
      onTap: () => Navigator.pushReplacementNamed(context, Routes.login),
      buttonText: AppString.backToLogin,
      fontColor: CustomColors.blackColor,
      backgroundColor: CustomColors.whiteColor,
    );
  }
}
