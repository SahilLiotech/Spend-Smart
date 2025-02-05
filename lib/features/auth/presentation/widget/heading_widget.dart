import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';

class HeadingWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const HeadingWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.25,
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/images/login_heading.svg",
            fit: BoxFit.fill,
            width: MediaQuery.sizeOf(context).width,
          ),
          Center(
            child: Column(
              spacing: 15,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: title,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: subtitle,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LottieHeadingWidget extends StatelessWidget {
  final String lottieAsset;

  const LottieHeadingWidget({
    super.key,
    required this.lottieAsset,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/login_heading.svg",
              fit: BoxFit.fill,
              width: MediaQuery.sizeOf(context).width,
            ),
          ),
          Positioned(
            top: 4,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.25,
              child: Lottie.asset(lottieAsset, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }
}
