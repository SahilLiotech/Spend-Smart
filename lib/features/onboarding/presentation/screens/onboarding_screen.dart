import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:spend_smart/features/onboarding/presentation/widget/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<OnboardingCubit>().controller = _pageController;
  }

  @override
  void dispose() {
    super.dispose();
    context.read<OnboardingCubit>().controller.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingCubitState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(controller: _pageController, children: [
            OnBoardingWidget(
              screenIndex: 0,
              title: AppString.onBoardingScreenTitle1,
              subtitle: AppString.onBoardingScreenSubTitle1,
              imageName: "onboarding1.svg",
              controller: _pageController,
            ),
            OnBoardingWidget(
              screenIndex: 1,
              title: AppString.onBoardingScreenTitle2,
              subtitle: AppString.onBoardingScreenSubtitle2,
              imageName: "onboarding2.svg",
              controller: _pageController,
            ),
            OnBoardingWidget(
              screenIndex: 2,
              title: AppString.onBoardingScreenTitle3,
              subtitle: AppString.onBoardingScreenSubtitle3,
              imageName: "onboarding3.svg",
              controller: _pageController,
            ),
          ]),
        );
      },
    );
  }
}
