import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/components/up_bar.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/auth/presentation/cubit/auth_state.dart';
import 'package:gap/gap.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitialState) {
          goToBase(context, Routes.welcome);
        }
      },

      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Gap(26),
              UpBar(
                isActive: false,
                onpicTap: () {
                  pushwithReplacement(context, Routes.customerHome);
                },
                icon1: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(Icons.arrow_back_ios),
                ),
                title: "Profile",
                icon: const Icon(Icons.person, color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthCubit>().logout();
                  pushTo(context, Routes.welcome);
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
