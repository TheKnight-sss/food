import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/components/up_bar.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/auth/models/admin_model.dart';
import 'package:food/features/admin/presentation/widget/counter.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/auth/presentation/cubit/auth_state.dart';
import 'package:gap/gap.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key, this.adminModel});
  final String coun1 = "Running Orders";
  final String coun2 = "Order Request";
  final AdminModel? adminModel;

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  User? user;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();
    final admin = cubit.adminData;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        
      },
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(26),
              UpBar(
                user: Text(user?.displayName ?? ""),
                color: AppColors.white,
                icon: GestureDetector(
                  onTap: () {
                    pushTo(context, Routes.photo, extra: user);
                  },
                  child: (admin?.image != null)
                    ? Image.network(
                      admin!.image!,
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    )
                    : CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.bgcolor,
                      child: Icon(Icons.person, color: AppColors.darkColor),
                    ),
                ),
              ),
              Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Counter(counter: widget.coun1)),
                  Gap(15),
                  Expanded(child: Counter(counter: widget.coun2)),
                ],
              ),
              Gap(16),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Gap(16),
              GestureDetector(
                child: Container(
                  height: 105,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(16),
                      Text("Review", style: Style.heading),
                    ],
                  ),
                ),
              ),
              Gap(16),
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
