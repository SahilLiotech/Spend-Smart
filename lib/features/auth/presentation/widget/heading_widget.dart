import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spend_smart/core/utils/custom_text_widget.dart';

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
