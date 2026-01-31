import 'package:flutter/material.dart';
import 'package:food/features/admin/presentation/pages/admin_dashboard_screen.dart';
import 'package:food/features/auth/models/user_type_enum.dart';
import 'package:food/features/auth/presentation/pages/login_screen.dart';
import 'package:food/features/auth/presentation/pages/photo_profile_screen.dart';
import 'package:food/features/auth/presentation/pages/signin_screen.dart';
import 'package:food/features/food/presentation/pages/add_item_screen.dart';
import 'package:food/features/home/presentation/pages/admin_home_screen.dart';
import 'package:food/features/menu/presentation/pages/admin_menu_screen.dart';
import 'package:food/features/home/presentation/pages/customer_home_screen.dart';
import 'package:food/features/onboarding/onboadring_screen.dart';
import 'package:food/features/splash/splash_screen.dart';
import 'package:food/features/welcome/welcome_screen.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String welcome = '/welcome';
  static const String photo = '/photo';
  static const String addItem = '/addItem';
  static const String register = '/register';
  static const String home = '/home';
  static const String adminMenu = '/adminmenu';
  static const String adminHome = '/adminhome';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String onboarding = '/onboarding';
  static const String admindashboard = '/admindashboard';

  static final GoRouter routes = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboadringScreen(),
      ),
      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: photo,
        builder: (context, state) =>
            PhotoProfileScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) =>
            LoginScreen(userType: state.extra as UserTypeEnum),
      ),
      GoRoute(
        path: register,
        builder: (context, state) =>
            SigninScreen(userType: state.extra as UserTypeEnum),
      ),
      GoRoute(path: home, builder: (context, state) => CustomerHomeScreen()),
      GoRoute(path: adminMenu, builder: (context, state) => AdminMenuScreen()),
      GoRoute(path: adminHome, builder: (context, state) => AdminHomeScreen()),
      GoRoute(path: addItem, builder: (context, state) => AddItemScreen()),
      GoRoute(
        path: admindashboard,
        builder: (context, state) => AdminDashboardScreen(),
      ),
    ],
  );
}
