import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

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
