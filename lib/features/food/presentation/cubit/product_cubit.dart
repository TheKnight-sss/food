import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/features/food/models/product_model.dart';
import 'package:food/features/food/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> addItem(ProductModel product) async {
    try {
      emit(ProductLoading());

      await FirebaseFirestore.instance
          .collection("products")
          .add(product.toJson());
      emit(ProductAdded());
    } catch (e) {
      emit(AddItemError(e.toString()));
    }
  }
}
