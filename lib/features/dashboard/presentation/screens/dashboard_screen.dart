import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_smart/config/routes/routes.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/button_widget.dart';
import 'package:spend_smart/core/utils/widgets/custom_toast.dart';
import 'package:spend_smart/features/auth/presentation/bloc/login_bloc/login_bloc.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LogoutFailure) {
              CustomToast.showSuccess(
                  context, AppString.failure, "LOG OUT FAILED");
            }
            if (state is LogoutSuccess) {
              CustomToast.showSuccess(
                  context, AppString.success, "LOG OUT SUCCESS");
            }
          },
          builder: (context, state) {
            return ButtonWidget(
                onTap: () {
                  context.read<LoginBloc>().add(LogoutEvent());
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.login, (route) => false);
                },
                buttonText: "Log Out");
          },
        ),
      ),
    );
  }
}
