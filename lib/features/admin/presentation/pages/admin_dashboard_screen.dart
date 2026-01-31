import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/components/up_bar.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/home/presentation/widgets/counter.dart';
import 'package:food/features/home/presentation/widgets/profile_icon.dart';
import 'package:gap/gap.dart';

class AdminDashboardScreen extends StatefulWidget {
 AdminDashboardScreen({super.key});
  final String coun1 = "Running Orders";
  final String coun2 = "Order Request";
  final User user = FirebaseAuth.instance.currentUser!;
  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(26),
              UpBar(
                user: Text(widget.user.displayName ?? ""),
                color: AppColors.white,
                icon: GestureDetector(
                  onTap: () {
                    pushTo(context, Routes.photo, extra: widget.user);
                  },
                  child: ProfileIcon(imageUrl: widget.user.photoURL, size: 24),
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
      );
  }
}