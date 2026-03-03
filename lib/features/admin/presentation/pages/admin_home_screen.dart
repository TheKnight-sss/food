import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/functions/show_dialog.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/features/admin/presentation/pages/admin_dashboard_screen.dart';
import 'package:food/features/admin/presentation/pages/admin_menu_screen.dart';
import 'package:food/features/admin/presentation/pages/admin_profile_screen.dart';
import 'package:food/features/auth/models/user_type_enum.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/auth/presentation/cubit/auth_state.dart';
import 'package:food/features/food/presentation/pages/add_item_screen.dart';
import 'package:food/features/admin/presentation/widget/custom_navigation_bar.dart';

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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context);
        } else if (state is AuthSuccessState) {
          if (state.role == UserTypeEnum.admin) {
            Navigator.pop(context);
            pushTo(context, Routes.admindashboard);
          }
        } else if (state is AuthFailureState) {
          Navigator.pop(context);
          showMyDialog(context, state.errorMessage, type: Dialogs.error);
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
