import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/features/auth/models/user_type_enum.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/auth/presentation/cubit/auth_state.dart';
import 'package:food/services/local/local_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late bool isOnboardingSeen;

  @override
  void initState() {
    super.initState();
    isOnboardingSeen = SharedPref.isOnboardingsSeen();

      Future.microtask(() {
      context.read<AuthCubit>().loadCurrentUser();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final isOnboardingSeen = SharedPref.isOnboardingsSeen();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          if (state.role == UserTypeEnum.admin) {
            pushwithReplacement(context, Routes.adminHome);
          } else {
            pushwithReplacement(context, Routes.customerHome);
          }
        }

        if (state is AuthInitialState) {
          if (isOnboardingSeen) {
            pushwithReplacement(context, Routes.welcome);
          } else {
            pushwithReplacement(context, Routes.onboarding);
          }
        }
      },

      child: Scaffold(
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
      ),
    );
  }
}
