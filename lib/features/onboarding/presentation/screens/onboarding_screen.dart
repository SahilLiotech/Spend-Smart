import 'package:flutter/material.dart';
import 'package:spend_smart/features/onboarding/presentation/widget/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OnBoardingWidget(
            screenIndex: 2,
            title: "This is first screen",
            subtitle: "This is Subtitle of out first onboarding screen",
            imageName: "onboarding1.svg"),
      ),
    );
  }
}
