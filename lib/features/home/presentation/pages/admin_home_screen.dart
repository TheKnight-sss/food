import 'package:flutter/material.dart';
import 'package:food/components/up_bar.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/features/auth/models/admin_model.dart';
import 'package:food/features/home/presentation/widgets/counter.dart';
import 'package:food/features/home/presentation/widgets/profile_icon.dart';
import 'package:gap/gap.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key, this.user});
  final String coun1 = "Running Orders";
  final String coun2 = "Order Request";
  final AdminModel? user ;

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(26),
              UpBar(user: Text(widget.user?.name ?? ""), color: AppColors.white, icon: ProfileIcon(imageUrl: widget.user?.image, size: 24)),
              Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Counter(counter: widget.coun1),
                  Gap(15),
                  Counter(counter: widget.coun2)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
