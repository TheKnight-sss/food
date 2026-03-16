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
import 'package:food/features/auth/presentation/widgets/_logincard.dart';
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
            // close loading dialog
            Navigator.pop(context);

            if (state.role == UserTypeEnum.admin) {
              pushTo(context, Routes.adminHome, extra: widget.userType);
            } else if (state.role == UserTypeEnum.customer) {
              pushTo(context, Routes.customerHome, extra: widget.userType);
            }
          } else if (state is AuthFailureState) {
            Navigator.pop(context);
            showMyDialog(context, state.errorMessage, type: Dialogs.error);
          }
        },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
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
                LoginCard(formKey: _formKey, cubit: cubit, widget: widget),
              ],
            ),
          ),
        ),
      );
    
  }
}
