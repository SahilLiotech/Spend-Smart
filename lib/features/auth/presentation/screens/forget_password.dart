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
  TextEditingController resetPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
      body: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccess) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => ResetPassWordConfirmationDialog(
                onResendEmail: () {
                  if (formKey.currentState!.validate()) {
                    context.read<ForgetPasswordBloc>().add(
                        ForgetPasswordSubmitted(
                            email: resetPasswordController.text));
                  }
                },
                onBackToLogin: () =>
                    Navigator.pushReplacementNamed(context, Routes.login),
              ),
            );
          }
          if(state is ForgetPasswordFailure){
            CustomToast.showFailure(context, AppString.failure ,state.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LottieHeadingWidget(
                    lottieAsset: "assets/lottie/forget_password_lottie.json",
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
                    validator: emailValidator,
                    controller: resetPasswordController,
                    labelText: AppString.enterEmailAddress,
                    width: MediaQuery.sizeOf(context).width * 0.9,
                  ),
                  ButtonWidget(
                    isLoading: state is ForgetPasswordLoading,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<ForgetPasswordBloc>().add(
                              ForgetPasswordSubmitted(
                                email: resetPasswordController.text,
                              ),
                            );
                      }
                    },
                    buttonText: AppString.resetPassword,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: OrDividerWidget(),
                  ),
                  ButtonWidget(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, Routes.login),
                    buttonText: AppString.backToLogin,
                    fontColor: CustomColors.blackColor,
                    backgroundColor: CustomColors.whiteColor,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
