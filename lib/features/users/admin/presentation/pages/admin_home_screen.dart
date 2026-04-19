import 'package:flutter/material.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/features/users/admin/presentation/pages/admin_dashboard_screen.dart';
import 'package:food/features/users/admin/presentation/pages/admin_menu_screen.dart';
import 'package:food/features/users/admin/presentation/pages/admin_profile_screen.dart';
import 'package:food/features/food/presentation/pages/add_item_screen.dart';
import 'package:food/features/users/admin/presentation/widget/custom_navigation_bar.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _currentIndex = 0;

  List<Widget> getPages = [
    AdminDashboardScreen(),
    AdminMenuScreen(),
    AddItemScreen(),
    AddItemScreen(),
    AdminProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: CustomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        backgroundColor: AppColors.bgcolor,
        body: getPages[_currentIndex],
      );
  }
}
