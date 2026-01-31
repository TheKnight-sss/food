import 'package:food/features/auth/models/admin_model.dart';
import 'package:food/features/auth/models/user_type_enum.dart';

class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState{
  final UserTypeEnum role;

  AuthSuccessState({required this.role,});
}

class AuthFailureState extends AuthState{
  final String errorMessage;
  AuthFailureState(this.errorMessage);
}