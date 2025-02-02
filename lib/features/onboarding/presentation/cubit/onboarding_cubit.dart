import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'onboarding_cubit_state.dart';

class OnboardingCubit extends Cubit<OnboardingCubitState> {
  late PageController controller;
  OnboardingCubit() : super(OnboardingCubitInitial());

  void nextScreen(int currentIndex) {
    if (currentIndex < 2) {
      controller.animateToPage(
        currentIndex + 1,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeIn,
      );
      emit(OnboardingCubitUpdated(screenIndex: currentIndex + 1));
    }
  }

  void previosScreen(int currentIndex) {
    if (currentIndex > 0) {
      controller.animateToPage(
        currentIndex - 1,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeIn,
      );
      emit(OnboardingCubitUpdated(screenIndex: currentIndex - 1));
    }
  }

  void skipScreen() {
    if (controller.page != 2) {
      controller.jumpToPage(2);
      emit(OnboardingCubitUpdated(screenIndex: 2));
    }
  }
}
