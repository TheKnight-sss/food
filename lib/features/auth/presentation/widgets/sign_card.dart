import 'package:flutter/material.dart';
import 'package:food/components/buttons/main_button.dart';
import 'package:food/components/inputs/custom_text_field.dart';
import 'package:food/components/inputs/password_text_field.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/auth/models/user_type_enum.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gap/gap.dart';

class SignCard extends StatelessWidget {
  const SignCard({
    super.key,
    required this.cubit,
    required GlobalKey<FormState> formKey,
    required this.userType,
  }) : _formKey = formKey;

  final AuthCubit cubit;
  final GlobalKey<FormState> _formKey;
  final UserTypeEnum userType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text("Name", style: Style.title)],
        ),
        Gap(8),
        CustomTextField(
          hint: "Name",
          controller: cubit.nameController,color: AppColors.accentcolor3,
        ),
        Gap(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text("Email", style: Style.title)],
        ),
        Gap(8),
        CustomTextField(
          hint: "example@gmail.com",
          controller: cubit.emailController,color: AppColors.accentcolor3,
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
            if (_formKey.currentState!.validate()) {
              cubit.register(type: userType);
            }
          },
        ),
      ],
    );
  }
}
