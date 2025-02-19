import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/widgets/custom_text_widget.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                      _buildDashboardContainer(width, height),
                      CustomText(
                        text: "Recent Transactions",
                        color: CustomColors.blackColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: CustomColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border(
                            left: BorderSide(
                                color: CustomColors.incomeColor, width: 6),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.hintTextColor,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Company Name",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.blackColor,
                                ),
                                CustomText(
                                  text: "18/01/2025",
                                  fontSize: 14,
                                  color: CustomColors.hintTextColor,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Salary",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.transactionCategoryColor,
                                ),
                                CustomText(
                                  text: "+10000",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.incomeColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: CustomColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border(
                            left: BorderSide(
                                color: CustomColors.expenseColor, width: 6),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.hintTextColor,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Swiggy",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.blackColor,
                                ),
                                CustomText(
                                  text: "18/01/2025",
                                  fontSize: 14,
                                  color: CustomColors.hintTextColor,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Food",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.transactionCategoryColor,
                                ),
                                CustomText(
                                  text: "+10000",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.expenseColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: CustomColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border(
                            left: BorderSide(
                                color: CustomColors.incomeColor, width: 6),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.hintTextColor,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Company Name",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.blackColor,
                                ),
                                CustomText(
                                  text: "18/01/2025",
                                  fontSize: 14,
                                  color: CustomColors.hintTextColor,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Salary",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.transactionCategoryColor,
                                ),
                                CustomText(
                                  text: "+10000",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.incomeColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContainer(double width, double height) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: CustomColors.dashBoardColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Dashboard",
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 5),
          _buildMainContainer(width, height),
          _buildRowContainers(width, height),
        ],
      ),
    );
  }

  Widget _buildMainContainer(double width, double height) {
    return Container(
        padding: EdgeInsets.all(16),
        height: 100,
        decoration: BoxDecoration(
          color: CustomColors.dashBoardContainerColor,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: CustomColors.whiteColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Total Balance",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: "Rs.5000",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
            SvgPicture.asset("assets/images/wallet_icon.svg"),
          ],
        ));
  }

  Widget _buildRowContainers(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSingleContainer(
            width, height, CustomColors.incomeColor, "Income", "Rs.3000"),
        _buildSingleContainer(
            width, height, CustomColors.expenseColor, "Expense", "Rs.2000"),
      ],
    );
  }

  Widget _buildSingleContainer(double width, double height, Color textColor,
      String text, String amount) {
    return Container(
      padding: EdgeInsets.all(16),
      width: width * 0.41,
      height: 100,
      decoration: BoxDecoration(
          color: CustomColors.dashBoardContainerColor,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: CustomColors.whiteColor)),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: text,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          CustomText(
            text: amount,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: textColor,
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Hello User",
              color: CustomColors.blackColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            CustomText(
              text: DateFormat('MMM dd, yyyy').format(DateTime.now()),
              color: CustomColors.blackColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset('assets/images/profile_icon.svg'),
        ),
      ],
    );
  }
}
