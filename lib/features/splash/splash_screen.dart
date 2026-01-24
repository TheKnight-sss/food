import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      var user = FirebaseAuth.instance.currentUser;

      Future.delayed(const Duration(seconds: 3), () {
          // if (user != null) {
            pushwithReplacement(context, Routes.adminHome);
          // } else {
          //   pushwithReplacement(context, Routes.onboarding);
          // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 5,
            left: -10,
            child: Image.asset(
              AppImages.ellipsesm,
              color: AppColors.accentcolor2,
            ),
          ),
          Positioned(
            bottom: 1,
            right: -5,
            child: Image.asset(AppImages.ellipsebg),
          ),
          Positioned.fill(child: Image.asset(AppImages.logo)),
        ],
      ),
    );
  }
}
