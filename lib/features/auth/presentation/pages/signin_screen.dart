import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class SigninScreen extends StatelessWidget {
   const SigninScreen({super.key, required this.userType});
  final UserTypeEnum userType;
  
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthSuccessState) {
            Navigator.pop(context);
            if (userType == UserTypeEnum.customer ||
                userType == UserTypeEnum.admin) {
              pushwithReplacement(context, Routes.login, extra: userType);
            }
          } else if (state is AuthFailureState) {
            Navigator.pop(context);
            showMyDialog(context, state.errorMessage, type: Dialogs.error);
          }
        },
        child: Form(
          key: cubit.formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Container(color: AppColors.accentcolor),
                  ),
                  Positioned(
                    top: 2,
                    left: -20,
                    child: Image.asset(
                      AppImages.ellipsesm,
                      color: AppColors.white,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: -5,
                    child: Image.asset(
                      AppImages.vector,
                      color: AppColors.primcolor,
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
                            "Sign Up",
                            style: Style.heading.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          Gap(3),
                          Text(
                            "Please sign up to get started",
                            style: Style.regular.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: 233,
                    left: 0,
                    right: 0,
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
                            children: [Text("Name", style: Style.title)],
                          ),
                          Gap(8),
                          CustomTextField(
                            hint: "Name",
                            controller: cubit.nameController,
                          ),
                          Gap(24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [Text("Email", style: Style.title)],
                          ),
                          Gap(8),
                          CustomTextField(
                            hint: "example@gmail.com",
                            controller: cubit.emailController,
                          ),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("RE-TYPE Password", style: Style.title),
                            ],
                          ),
                          Gap(8),
                          PasswordTextField(
                            hint: "*************",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                          ),
                          Gap(25),
                          CustomButton(
                            txt: "Sign Up",
                            onpressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.register(type: userType);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
