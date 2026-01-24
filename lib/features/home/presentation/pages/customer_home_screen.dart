import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/components/up_bar.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:gap/gap.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsGeometry.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(30),
              UpBar(user: Text(user?.displayName ?? ""),icon: Icon(Icons.shopping_bag_outlined), color: AppColors.accentcolor4),
              Gap(55),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search dishes",
                  hintStyle: TextStyle(color: AppColors.txtcolor2),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      width: 20,
                      height: 20,
                      AppImages.search,
                      color: AppColors.icon2,
                    ),
                  ),
                ),
              ),
              Gap(32),
              Row(
                children: [
                  Text("All Categories", style: Style.title),
                ],
              ),
              Gap(20)
            ],
          ),
        ),
      ),
    );
  }
}
