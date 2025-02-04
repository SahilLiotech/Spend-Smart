import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spend_smart/core/utils/widgets/button_widget.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class OnboardingBottomSheet extends StatelessWidget {
  final int index;

  const OnboardingBottomSheet({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              context.read<OnboardingCubit>().nextScreen(index);
            },
            child: SvgPicture.asset("assets/images/onboarding_next_icon.svg"),
          ),
        ],
      );
    } else if (index == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.read<OnboardingCubit>().previosScreen(index);
            },
            child:
                SvgPicture.asset("assets/images/onboarding_previous_icon.svg"),
          ),
          GestureDetector(
            onTap: () {
              context.read<OnboardingCubit>().nextScreen(index);
            },
            child: SvgPicture.asset("assets/images/onboarding_next_icon.svg"),
          ),
        ],
      );
    } else if (index == 2) {
      return Center(
        child: ButtonWidget(
          onTap: () {
            context.read<OnboardingCubit>().navigateToLogin();
          },
          buttonText: AppString.getStarted,
          fontColor: CustomColors.primaryColor,
          backgroundColor: CustomColors.whiteColor,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
