import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/components/buttons/main_button.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/functions/show_dialog.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/auth/models/user_type_enum.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/auth/presentation/cubit/auth_state.dart';
import 'package:food/features/home/presentation/widgets/profile_icon.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class PhotoProfileScreen extends StatefulWidget {
  PhotoProfileScreen({super.key, this.userType});
  final UserTypeEnum? userType;
  var formKey = GlobalKey<FormState>();

  @override
  State<PhotoProfileScreen> createState() => _PhotoProfileScreenState();
}

class _PhotoProfileScreenState extends State<PhotoProfileScreen> {
  File? file;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context);
        } else if (state is AuthSuccessState) {
          Navigator.pop(context);
          pushTo(context, Routes.login);
        } else if (state is AuthFailureState) {
          Navigator.pop(context);
          showMyDialog(context, state.errorMessage, type: Dialogs.error);
        }
      },
      child: Scaffold(
        body: Form(
          key: cubit.formKey,
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
                  color: AppColors.primcolor,
                ),
              ),
              Positioned.fill(
                top: 300,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "Profile Photo",
                        style: Style.heading.copyWith(color: AppColors.white),
                      ),
                      Gap(20),
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.icon,
                        child: ProfileIcon(
                          imageUrl: file?.path,
                          size: 60,
                        ),
                      ),
                      Gap(20),
                      CustomButton(
                        txt: "Choose from Gallery",
                        onpressed: () => uploadImages(isCamera: false),
                      ),
                      Gap(10),
                      CustomButton(
                        txt: "Take a Photo",
                        onpressed: () => uploadImages(isCamera: true),
                      ),
                      Gap(30),
                      CustomButton(
                        txt: "Continue",
                        onpressed: () {
                          goToBase(context, Routes.adminHome);
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
    );
  }

  Future<void> uploadImages({required bool isCamera}) async {
    XFile? pickedfile = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedfile != null) {
      setState(() {
        pop(context);
        file = File(pickedfile.path);
      });
    }
  }
}
