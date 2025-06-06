import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.onItemSelected,
    this.selectedIndex = 0,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: CustomColors.whiteColor,
      elevation: 12.0,
      notchMargin: 8.0,
      child: SizedBox(
        // height: 70,
        child: Row(
          spacing: 6,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem("assets/images/home_icon.svg", AppString.home, 0),
            _buildNavItem("assets/images/transaction_icon.svg",
                AppString.transacations, 1),
            const SizedBox(width: 50),
            _buildNavItem(
                "assets/images/category_icon.svg", AppString.categories, 3),
            _buildNavItem("assets/images/budget_icon.svg", AppString.budget, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    return InkWell(
      onTap: () {
        if (widget.selectedIndex != index) {
          widget.onItemSelected(index);
        }
      },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Column(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            height: 24,
            width: 24,
            colorFilter: widget.selectedIndex == index
                ? ColorFilter.mode(CustomColors.primaryColor, BlendMode.srcIn)
                : ColorFilter.mode(CustomColors.hintTextColor, BlendMode.srcIn),
          ),
          CustomText(
            text: label,
            fontSize: widget.selectedIndex == index ? 14 : 12,
            fontWeight: widget.selectedIndex == index
                ? FontWeight.w600
                : FontWeight.w500,
            color: widget.selectedIndex == index
                ? CustomColors.primaryColor
                : CustomColors.hintTextColor,
          ),
        ],
      ),
    );
  }
}
