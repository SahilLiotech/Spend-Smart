part of 'onboarding_cubit.dart';

sealed class OnboardingCubitState extends Equatable {
  const OnboardingCubitState();

  @override
  List<Object> get props => [];
}

final class OnboardingCubitInitial extends OnboardingCubitState {}

final class OnboardingCubitUpdated extends OnboardingCubitState {
  final int screenIndex;

  const OnboardingCubitUpdated({required this.screenIndex});

  @override
  List<Object> get props => [screenIndex];
}

final class OnboardingNavigation extends OnboardingCubitState {}
