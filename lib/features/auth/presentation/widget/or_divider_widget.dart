import 'package:flutter/material.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';

class OrDividerWidget extends StatelessWidget {
  final String text;
  final Color dividerColor;
  final double thickness;
  final TextStyle? textStyle;

  const OrDividerWidget({
    super.key,
    this.text = AppString.or,
    this.dividerColor = CustomColors.blackColor,
    this.thickness = 1.0,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: thickness,
            color: dividerColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomText(
            text: text,
            color: CustomColors.blackColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        Expanded(
          child: Divider(
            thickness: thickness,
            color: dividerColor,
          ),
        ),
      ],
    );
  }
}
