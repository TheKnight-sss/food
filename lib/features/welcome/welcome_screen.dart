import 'package:flutter/material.dart';
import 'package:food/components/buttons/main_button.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/features/auth/models/user_type_enum.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});
  var formKey = GlobalKey<FormState>();

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: Container(color: AppColors.accentcolor)),
          Positioned(
            top: 2,
            left: -20,
            child: Image.asset(AppImages.ellipsesm, color: AppColors.white),
          ),
          Positioned(
            top: 0,
            right: -5,
            child: Image.asset(
              AppImages.vector,
              color: AppColors.accentcolor2,
            ),
          ),
          Positioned.fill(            
            child: Align(
              alignment: Alignment.center,
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(txt: "Admin", onpressed: (){
                    pushTo(context, Routes.login, extra: UserTypeEnum.admin);
                  },),
                  Gap(10),
                  CustomButton(txt: " Customer", onpressed: (){
                    pushTo(context, Routes.login, extra: UserTypeEnum.customer);
                  },),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
