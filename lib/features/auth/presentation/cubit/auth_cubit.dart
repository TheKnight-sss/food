import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/functions/image_uploader.dart';
import 'package:food/features/auth/models/admin_model.dart';
import 'package:food/features/auth/models/customer_model.dart';
import 'package:food/features/auth/models/user_type_enum.dart';
import 'package:food/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
     emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      emit(AuthSuccessState(role: credential.user?.photoURL == 'admin' ? UserTypeEnum.admin : UserTypeEnum.customer,));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailureState("The user not found"));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailureState("The password is incorrect"));
      }else if(e.code == 'invalid-email'){
        emit(AuthFailureState("The email is invalid"));
      }
    }
  }
  Future<void> register({required UserTypeEnum type}) async {
    emit(AuthLoadingState());

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      User? user = credential.user;
      //! Use photo URL as Role
      await user?.updatePhotoURL(type == UserTypeEnum.admin ? 'admin' : 'customer');
      await user?.updateDisplayName(nameController.text);

      //then store additional user info in firestore if needed
      if (type == UserTypeEnum.admin) {
        var admin = AdminModel(
          
          uid: user?.uid,
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseFirestore.instance
            .collection('admins')
            .doc(user?.uid)
            .set(admin.toJson());
      } else if (type == UserTypeEnum.customer) {
        await FirebaseFirestore.instance
            .collection('customers')
            .doc(user?.uid)
            .set({
              'uid': user?.uid,
              'name': nameController.text,
              'email': emailController.text,
            });
      }

      emit(AuthSuccessState(role: type,));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailureState("كلمة المرور ضعيفة جدا"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailureState("البريد الإلكتروني مستخدم بالفعل"));
      } else {
        emit(AuthFailureState("فشل في المصادقة, يرجى المحاولة مرة أخرى"));
      }
    } catch (e) {
      emit(AuthFailureState("فشل في المصادقة"));
    }
  }

  Future<void> updateAdminData([File? pickedImage]) async{
    emit(AuthLoadingState());
    try {
      String? imageUrl = await updateImageToCloudinary(pickedImage!);
      if (imageUrl == null) {
        emit(AuthFailureState("فشل في رفع الصورة"));
        return;
      }
      var admin = AdminModel(
        uid: FirebaseAuth.instance.currentUser?.uid,
        name: nameController.text,
        email: emailController.text,
        image: imageUrl,
      );
      await FirebaseFirestore.instance
          .collection('admins')
          .doc(admin.uid)
          .update(admin.toJson());
    } on Exception catch (_) {
      emit(AuthFailureState("فشل في تحديث البيانات"));
    }
  }

  Future<void> updateCustomerData([File? pickedImage]) async{
    emit(AuthLoadingState());
    try {
      String? imageUrl = await updateImageToCloudinary(pickedImage!);
      if (imageUrl == null) {
        emit(AuthFailureState("فشل في رفع الصورة"));
        return;
      }
      var customer = CustomerModel(
        uid: FirebaseAuth.instance.currentUser?.uid,
        name: nameController.text,
        email: emailController.text,
        image: imageUrl,
      );
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customer.uid)
          .update(customer.toJson());
    } on Exception catch (_) {
      emit(AuthFailureState("فشل في تحديث البيانات"));
    }
  }
}
