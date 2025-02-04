import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';
import 'package:spend_smart/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class OnBoardingWidget extends StatefulWidget {
  final int screenIndex;
  final String title;
  final String subtitle;
  final String imageName;
  const OnBoardingWidget({
    super.key,
    required this.screenIndex,
    required this.title,
    required this.subtitle,
    required this.imageName,
  });

  @override
  State<OnBoardingWidget> createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(color: CustomColors.primaryColor),
      child: Column(
        spacing: 20,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                width: MediaQuery.sizeOf(context).width,
                child: SvgPicture.asset(
                  "assets/images/onboarding_background.svg",
                  fit: BoxFit.fill,
                ),
              ),
              SvgPicture.asset(
                "assets/images/${widget.imageName}",
                fit: BoxFit.contain,
              ),
              if (widget.screenIndex != 2)
                Positioned(
                  top: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<OnboardingCubit>().skipScreen();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor,
                      foregroundColor: CustomColors.whiteColor,
                    ),
                    child: CustomText(
                      text: AppString.skip,
                      fontSize: 15,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              children: [
                CustomText(
                  textAlign: TextAlign.center,
                  text: widget.title,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  textAlign: TextAlign.center,
                  text: widget.subtitle,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
