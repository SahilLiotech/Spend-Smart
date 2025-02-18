import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spend_smart/core/utils/custom_colors.dart';
import 'package:spend_smart/core/utils/widgets/bottom_navigation_bar.dart';
import 'package:spend_smart/features/budget/presentation/screens/budget_screen.dart';
import 'package:spend_smart/features/category/presentation/screens/category_screen.dart';
import 'package:spend_smart/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:spend_smart/features/main/presentation/bloc/navigation_cubit.dart';
import 'package:spend_smart/features/transactions/presentation/screens/transaction_screen.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: CustomColors.secondaryColor,
          body: _buildScreen(currentIndex),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              context.read<NavigationCubit>().updateIndex(2);
            },
            child: SvgPicture.asset("assets/images/add_icon.svg"),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: currentIndex,
            onItemSelected: (index) {
              context.read<NavigationCubit>().updateIndex(index);
            },
          ),
        );
      },
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const DashBoardScreen();
      case 1:
        return const TransactionScreen();
      case 2:
        return const TransactionScreen();
      case 3:
        return const CategoryScreen();
      case 4:
        return const BudgetScreen();
      default:
        return const DashBoardScreen();
    }
  }
}
