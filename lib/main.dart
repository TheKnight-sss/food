import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/themes.dart';
import 'package:food/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:food/firebase_options.dart';
import 'package:food/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food/features/food/presentation/cubit/product_cubit.dart';
import 'package:food/features/orders/presentation/cubit/order_cubit.dart';
import 'package:food/services/local/local_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPref.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => OrderCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: Routes.routes,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
