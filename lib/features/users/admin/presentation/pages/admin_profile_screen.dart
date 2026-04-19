import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/users/admin/presentation/widget/profile_card.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/auth/presentation/cubit/auth_state.dart';
import 'package:gap/gap.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();
    final admin = cubit.adminData;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitialState) {
          // go back to welcome page once logout completes
          goToBase(context, Routes.welcome);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 271),
          child: Container(
            padding: const EdgeInsets.only(top: 50, left: 24),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: AppColors.primcolor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            alignment: Alignment.centerLeft,
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Gap(16),
                      Text(
                        'My Profile',
                        style: Style.title.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Gap(24),
                  Text("Available Balance", style: Style.body.copyWith(color: Colors.white)),
                  Text(
                    admin != null ? "\$${admin.balance.toStringAsFixed(2)}" : "\$0.00",
                    style: Style.Extra.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            spacing: 15,
            children: [
              //! Profile Info
              SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.search,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(27, 13, 17.25, 17),
                    child: Column(
                      children: [
                        ProfileCard(
                          isOk: true,
                          done: true,
                          txt: "Personal Info",
                          color: AppColors.primcolor,
                          asset: AppImages.user2,
                        ),
                        Gap(15),
                        ProfileCard(
                          isOk: false,
                          done: true,
                          txt: "Settings",
                          color: AppColors.settings,
                          asset: AppImages.setting,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //! Orders and Withdrawals
              Container(
                decoration: BoxDecoration(
                  color: AppColors.search,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(27, 13, 17.25, 17),
                  child: Column(
                    children: [
                      ProfileCard(
                        txt: "Withdrawal History",
                        asset: AppImages.withdrawal,
                        isOk: false,
                        done: true,
                        color: AppColors.primcolor,
                      ),
                      Gap(15),
                      ProfileCard(
                        txt: "Numbers of Orders",
                        asset: AppImages.orders,
                        isOk: false,
                        done: false,
                        color: AppColors.userReviews,
                      ),
                    ],
                  ),
                ),
              ),
              //! Reviews and Logout
              Container(
                decoration: BoxDecoration(
                  color: AppColors.search,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(27, 13, 17.25, 17),
                  child: ProfileCard(
                    txt: "User Reviews",
                    asset: AppImages.orderreview,
                    isOk: false,
                    done: true,
                    color: AppColors.userReviews,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  cubit.logout();
                },
                child: SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.search,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(27, 13, 17.25, 17),
                      child: ProfileCard(
                        txt: "Log Out",
                        asset: AppImages.logOut,
                        isOk: false,
                        done: true,
                        color: AppColors.logOut,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
