import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/auth/presentation/cubit/auth_state.dart';

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
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
              pushTo(context, Routes.welcome);
            },
            child: const Text('Sign Out'),
          ),
        ),
      ),
    );
  }
}
