import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/components/buttons/main_button.dart';
import 'package:food/components/inputs/custom_text_field.dart';
import 'package:food/components/inputs/password_text_field.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/functions/show_dialog.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/auth/models/user_type_enum.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/auth/presentation/cubit/auth_state.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.userType});
  final UserTypeEnum? userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthSuccessState) {
            if (state.role == "admin") {
              Navigator.pop(context);
              pushTo(context, Routes.adminHome,extra: widget.userType);
            }
            if (state.role == "customer") {
              Navigator.pop(context);
              pushTo(context, Routes.home, extra: widget.userType);
            }
          } else if (state is AuthFailureState) {
            Navigator.pop(context);
            showMyDialog(context, state.errorMessage, type: Dialogs.error);
          }
        },
        child: Stack(
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
            Positioned(
              top: 118,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Log In",
                      style: Style.heading.copyWith(color: AppColors.white),
                    ),
                    Gap(3),
                    Text(
                      "Please sign in to your existing account",
                      style: Style.regular.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
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
          ],
        ),
      ),
    );
  }
}
