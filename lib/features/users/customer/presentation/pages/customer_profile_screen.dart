import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/components/up_bar.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/auth/presentation/cubit/auth_state.dart';
import 'package:food/features/users/admin/presentation/widget/profile_card.dart';
import 'package:gap/gap.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final customer = cubit.customerData;
    final photo = customer?.image;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitialState) {
          goToBase(context, Routes.welcome);
        }
      },

      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Gap(26),
                UpBar(
                  isActive: false,
                  onpicTap: () {
                    pushwithReplacement(context, Routes.customerHome);
                  },
                  icon1: Icon(Icons.arrow_back_ios_new),
                  title: "Profile",
                  icon: const Icon(Icons.person, color: Colors.white),
                ),
                Gap(24),
                Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundColor: AppColors.photo,
                        child: photo != null
                            ? Image.network(photo, fit: BoxFit.cover)
                            : Icon(Icons.person, color: Colors.grey[500]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Column(
                        children: [
                          Text(
                            customer?.name ?? "",
                            style: Style.title.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(32),
                  ],
                ),
                Gap(32),
                //! Profile Info
                Column(
                  spacing: 15,
                  children: [
                    SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.search,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(27, 13, 17.25, 17),
                          child: Column(
                            spacing: 15,
                            children: [
                              ProfileCard(
                                isOk: true,
                                done: true,
                                txt: "Personal Info",
                                color: AppColors.primcolor,
                                asset: AppImages.user2,
                              ),
                              ProfileCard(
                                isOk: true,
                                done: true,
                                txt: "Addresses",
                                color: AppColors.settings,
                                asset: AppImages.address,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.search,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(27, 13, 17.25, 17),
                          child: Column(
                            spacing: 15,
                            children: [
                              ProfileCard(
                                isOk: true,
                                done: true,
                                txt: "Cart",
                                color: AppColors.cart,
                                asset: AppImages.cart,
                              ),
                              ProfileCard(
                                isOk: true,
                                done: true,
                                txt: "Favourite",
                                color: AppColors.settings,
                                asset: AppImages.favourite,
                              ),
                              ProfileCard(
                                txt: "Notifications",
                                asset: AppImages.bell,
                                isOk: true,
                                done: true,
                                color: AppColors.bell,
                              ),
                              ProfileCard(
                                txt: "Payment Method",
                                asset: AppImages.credit,
                                isOk: true,
                                done: true,
                                color: AppColors.cart,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.search,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(27, 13, 17.25, 17),
                          child: Column(
                            spacing: 15,
                            children: [
                              ProfileCard(
                                isOk: true,
                                done: true,
                                txt: "Cart",
                                color: AppColors.cart,
                                asset: AppImages.cart,
                              ),
                              ProfileCard(
                                isOk: true,
                                done: true,
                                txt: "Favourite",
                                color: AppColors.settings,
                                asset: AppImages.favourite,
                              ),
                              ProfileCard(
                                txt: "Notifications",
                                asset: AppImages.bell,
                                isOk: true,
                                done: true,
                                color: AppColors.bell,
                              ),
                              ProfileCard(
                                txt: "Payment Method",
                                asset: AppImages.credit,
                                isOk: true,
                                done: true,
                                color: AppColors.cart,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    cubit.logout();
                    pushTo(context, Routes.welcome);
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
