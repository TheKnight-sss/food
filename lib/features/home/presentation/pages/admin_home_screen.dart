import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/features/admin/presentation/pages/admin_dashboard_screen.dart';
import 'package:food/features/auth/models/admin_model.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/auth/presentation/cubit/auth_state.dart';
import 'package:food/features/food/presentation/pages/add_item_screen.dart';
import 'package:food/features/home/presentation/widgets/custom_navigation_bar.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _currentIndex = 0;
  
  List<Widget> getPages(AdminModel? user) {
    return [
      AdminDashboardScreen(),
      AdminHomeScreen(),
      AddItemScreen()
    ];
  }
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
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          AdminModel? user;
          if (authState is AuthSuccessState) {
            user = authState.role as AdminModel?;
          }
          final pages = getPages(user);
          return pages[_currentIndex];
        },
      ),
    );
  }
}
