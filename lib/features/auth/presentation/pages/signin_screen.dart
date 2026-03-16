import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/functions/show_dialog.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/auth/models/user_type_enum.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/auth/presentation/cubit/auth_state.dart';
import 'package:food/features/auth/presentation/widgets/sign_card.dart';
import 'package:gap/gap.dart';

class SigninScreen extends StatelessWidget {
   SigninScreen({super.key, required this.userType});
  final UserTypeEnum userType;
  final _formKey = GlobalKey<FormState>();
  
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
          key: _formKey,
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
                      child: SignCard(cubit: cubit, formKey: _formKey, userType: userType),
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
