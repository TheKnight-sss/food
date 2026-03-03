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

  Future<void> loadCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;

    // 🔹 No logged-in user
    if (user == null) {
      emit(AuthInitialState());
      return;
    }

    // 🔹 User is logged in, determine role and emit success
    final role = user.photoURL == 'admin'
        ? UserTypeEnum.admin
        : UserTypeEnum.customer;

    AdminModel? adminModel;
    if (role == UserTypeEnum.admin) {
      final doc = await FirebaseFirestore.instance
          .collection('admins')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        adminModel = AdminModel.fromJson(doc.data()!);
        adminData = adminModel;
      }
    }
      CustomerModel? customModel;
    if (role == UserTypeEnum.customer) {
      final doc = await FirebaseFirestore.instance
          .collection('customers')
          .doc(user.uid)
          .get();
          if (doc.exists) {
            customModel = CustomerModel.fromJson(doc.data()!);
            customerData = customModel;
          }
    }

    emit(AuthSuccessState(role: role, adminModel: adminData, customerModel: customerData));
  }

  AdminModel? adminData;
  CustomerModel? customerData;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
      await user?.updatePhotoURL(
        type == UserTypeEnum.admin ? 'admin' : 'customer',
      );
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
        var customer = CustomerModel(
            uid: user?.uid,
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseFirestore.instance
            .collection('customers')
            .doc(user?.uid)
            .set(customer.toJson());
      }

      emit(AuthSuccessState(role: type, adminModel: adminData));
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

  Future<void> login() async {
    emit(AuthLoadingState());

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final role = credential.user?.photoURL == 'admin'
          ? UserTypeEnum.admin
          : UserTypeEnum.customer;

      if (role == UserTypeEnum.admin) {
        final doc = await FirebaseFirestore.instance
            .collection('admins')
            .doc(credential.user!.uid)
            .get();

        adminData = AdminModel.fromJson(doc.data()!);
      } else if (role == UserTypeEnum.customer) {
        final doc2 = await FirebaseFirestore.instance
            .collection('customers')
            .doc(credential.user!.uid)
            .get();
        customerData = CustomerModel.fromJson(doc2.data()!);
      }

      emit(AuthSuccessState(role: role, adminModel: adminData, customerModel: customerData));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailureState("The user not found"));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailureState("The password is incorrect"));
      } else if (e.code == 'invalid-email') {
        emit(AuthFailureState("The email is invalid"));
      } else {
        emit(AuthFailureState("Login failed"));
      }
    }
  }

  Future<void> updateAdminData([File? pickedImage]) async {
    emit(AuthLoadingState());
    try {
      if (pickedImage == null) {
        emit(AuthFailureState("فشل في رفع الصورة"));
        return;
      }
      String? imageUrl = await updateImageToCloudinary(pickedImage!);

      adminData = AdminModel(
        uid: FirebaseAuth.instance.currentUser?.uid,
        name: nameController.text,
        email: emailController.text,
        image: imageUrl,
      );

      await FirebaseFirestore.instance
          .collection('admins')
          .doc(adminData!.uid)
          .update({'image': imageUrl});
      emit(AuthSuccessState(role: UserTypeEnum.admin, adminModel: adminData));
    } on Exception catch (_) {
      emit(AuthFailureState("فشل في تحديث البيانات"));
    }
  }

  Future<void> updateCustomerData([File? pickedImage]) async {
    emit(AuthLoadingState());
    try {
      String? imageUrl = await updateImageToCloudinary(pickedImage!);
      if (imageUrl == null) {
        emit(AuthFailureState("فشل في رفع الصورة"));
        return;
      }
      var customerData = CustomerModel(
        uid: FirebaseAuth.instance.currentUser?.uid,
        name: nameController.text,
        email: emailController.text,
        image: imageUrl,
      );
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerData.uid)
          .update(customerData.toJson());
      emit(AuthSuccessState(role: UserTypeEnum.customer, customerModel: customerData));
    } on Exception catch (_) {
      emit(AuthFailureState("فشل في تحديث البيانات"));
    }
  }

  Future<void> logout() async {
    emit(AuthLoadingState());

    await FirebaseAuth.instance.signOut();

    // clear cached data
    adminData = null;
    nameController.clear();
    emailController.clear();
    passwordController.clear();

    emit(AuthInitialState());
  }
}
