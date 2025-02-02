import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spend_smart/config/routes/routes.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:spend_smart/features/onboarding/presentation/widget/onboarding_bottomsheet.dart';
import 'package:spend_smart/features/onboarding/presentation/widget/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    context.read<OnboardingCubit>().controller = _pageController;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return BlocListener<OnboardingCubit, OnboardingCubitState>(
      listener: (context, state) {
        if (state is OnboardingNavigation) {
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      },
      child: BlocBuilder<OnboardingCubit, OnboardingCubitState>(
        builder: (context, state) {
          final currentIndex =
              state is OnboardingCubitUpdated ? state.screenIndex : 0;

          return Scaffold(
            body: PageView.builder(
              controller: _pageController,
              itemCount: 3,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return OnBoardingWidget(
                      screenIndex: 0,
                      title: AppString.onBoardingScreenTitle1,
                      subtitle: AppString.onBoardingScreenSubTitle1,
                      imageName: "onboarding1.svg",
                    );
                  case 1:
                    return OnBoardingWidget(
                      screenIndex: 1,
                      title: AppString.onBoardingScreenTitle2,
                      subtitle: AppString.onBoardingScreenSubtitle2,
                      imageName: "onboarding2.svg",
                    );
                  case 2:
                    return OnBoardingWidget(
                      screenIndex: 2,
                      title: AppString.onBoardingScreenTitle3,
                      subtitle: AppString.onBoardingScreenSubtitle3,
                      imageName: "onboarding3.svg",
                    );
                  default:
                    return Container();
                }
              },
            ),
            bottomSheet: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 120,
              width: width,
              color: CustomColors.primaryColor,
              child: Column(
                spacing: 20,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: WormEffect(
                      activeDotColor: CustomColors.whiteColor,
                      spacing: 15,
                      dotColor: Colors.grey.shade400,
                    ),
                  ),
                  OnboardingBottomSheet(index: currentIndex),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
