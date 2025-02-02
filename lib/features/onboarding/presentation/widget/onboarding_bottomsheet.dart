import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spend_smart/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class OnboardingBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingCubitState>(
      builder: (context, state) {
        if (state is OnboardingCubitUpdated) {
          int currentIndex = state.screenIndex;
          return Container(
            height: 150,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: OnboardingCubit.of(context).controller,
                  count: 3,
                  effect: WormEffect(),
                ),
                if (currentIndex == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          OnboardingCubit.of(context).nextScreen(currentIndex);
                        },
                        child: Text('Next'),
                      ),
                    ],
                  ),
                if (currentIndex == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          OnboardingCubit.of(context)
                              .previosScreen(currentIndex);
                        },
                        child: Text('Previous'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          OnboardingCubit.of(context).nextScreen(currentIndex);
                        },
                        child: Text('Next'),
                      ),
                    ],
                  ),
                if (currentIndex == 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          OnboardingCubit.of(context).skipScreen();
                        },
                        child: Text('Get Started'),
                      ),
                    ],
                  ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
