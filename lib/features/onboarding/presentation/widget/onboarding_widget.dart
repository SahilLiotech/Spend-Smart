import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_smart/core/utils/button_widget.dart';
import 'package:spend_smart/core/utils/colors.dart';
import 'package:spend_smart/core/utils/text_widget.dart';

class OnBoardingWidget extends StatefulWidget {
  final int screenIndex;
  final String title;
  final String subtitle;
  final String imageName;
  const OnBoardingWidget(
      {super.key,
      required this.screenIndex,
      required this.title,
      required this.subtitle,
      required this.imageName});

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
                  top: 15,
                  right: 10,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor,
                      foregroundColor: CustomColors.whiteColor,
                    ),
                    child: CustomText(
                      text: "Skip",
                      fontSize: 15,
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                CustomText(
                  text: widget.title,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text: widget.subtitle,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: _getButtonAlignment(),
                children: _getBottomButtons(),
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
          onTap: () {},
          child: SvgPicture.asset("assets/images/onboarding_next_icon.svg"),
        ),
      ];
    } else if (widget.screenIndex == 1) {
      return [
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset("assets/images/onboarding_previous_icon.svg"),
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset("assets/images/onboarding_next_icon.svg"),
        ),
      ];
    } else if (widget.screenIndex == 2) {
      return [
        ButtonWidget(
          onTap: () {},
          buttonText: "Get Started",
          fontColor: CustomColors.primaryColor,
          backgroundColor: CustomColors.whiteColor,
        ),
      ];
    }
    return [];
  }
}
