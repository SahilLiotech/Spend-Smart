import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spend_smart/core/utils/button_widget.dart';
import 'package:spend_smart/core/utils/colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/text_widget.dart';
import 'package:spend_smart/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class OnBoardingWidget extends StatefulWidget {
  final int screenIndex;
  final String title;
  final String subtitle;
  final String imageName;
  final PageController controller;
  const OnBoardingWidget(
      {super.key,
      required this.screenIndex,
      required this.title,
      required this.subtitle,
      required this.imageName,
      required this.controller});

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
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                width: MediaQuery.sizeOf(context).width,
                child: SvgPicture.asset(
                  "assets/images/onboarding_background.svg",
                  fit: BoxFit.fill, // Fit to container size
                ),
              ),
              // Top image (onboarding1)
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
          Expanded(
            child: Padding(
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
          ),
          SmoothPageIndicator(
              controller: widget.controller,
              count: 3,
              effect: ScaleEffect(
                activeDotColor: CustomColors.whiteColor,
                scale: 1.5,
                spacing: 15,
                dotColor: Colors.grey.shade400,
              )),
          Expanded(
            child: SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: _getButtonAlignment(),
                  children: _getBottomButtons(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  MainAxisAlignment _getButtonAlignment() {
    if (widget.screenIndex == 1) {
      return MainAxisAlignment.spaceBetween;
    }
    return MainAxisAlignment.center;
  }

  List<Widget> _getBottomButtons() {
    if (widget.screenIndex == 0) {
      return [
        GestureDetector(
          onTap: () {
            context.read<OnboardingCubit>().nextScreen(widget.screenIndex);
          },
          child: SvgPicture.asset("assets/images/onboarding_next_icon.svg"),
        ),
      ];
    } else if (widget.screenIndex == 1) {
      return [
        GestureDetector(
          onTap: () {
            context.read<OnboardingCubit>().previosScreen(widget.screenIndex);
          },
          child: SvgPicture.asset("assets/images/onboarding_previous_icon.svg"),
        ),
        GestureDetector(
          onTap: () {
            context.read<OnboardingCubit>().nextScreen(widget.screenIndex);
          },
          child: SvgPicture.asset("assets/images/onboarding_next_icon.svg"),
        ),
      ];
    } else if (widget.screenIndex == 2) {
      return [
        ButtonWidget(
          onTap: () {},
          buttonText: AppString.getStarted,
          fontColor: CustomColors.primaryColor,
          backgroundColor: CustomColors.whiteColor,
        ),
      ];
    }
    return [];
  }
}
