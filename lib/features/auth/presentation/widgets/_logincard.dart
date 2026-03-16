import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/components/buttons/main_button.dart';
import 'package:food/components/inputs/custom_text_field.dart';
import 'package:food/components/inputs/password_text_field.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/auth/presentation/pages/login_screen.dart';
import 'package:gap/gap.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
    required this.widget,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final AuthCubit cubit;
  final LoginScreen widget;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 233,
      left: 0,
      right: 0,
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text("Email", style: Style.title)],
                ),
                Gap(8),
                CustomTextField(hint: "example@gmail.com",
                controller: cubit.emailController,
                color: AppColors.accentcolor3,
                keyboardType: TextInputType.emailAddress,),
                Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text("Password", style: Style.title)],
                ),
                Gap(8),
                PasswordTextField(
                  hint: "*************",
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  controller: cubit.passwordController,
                ),
                Gap(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Forgot Password?",
                        style: Style.regular.copyWith(
                          color: AppColors.primcolor,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(31),
                CustomButton(txt: "Log In", onpressed: () {
                  cubit.login();
                }),
                Gap(38),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ", style: Style.regular),
                    GestureDetector(
                      onTap: () {
                        pushTo(context, Routes.register, extra: widget.userType);
                      },
                      child: Text(
                        "Sign Up",
                        style: Style.regular.copyWith(
                          color: AppColors.primcolor,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(28),
                Text("OR", style: Style.heading),
                Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 62,
                        width: 62,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withAlpha(180),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppImages.google,
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: SvgPicture.asset(AppImages.facebook),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
