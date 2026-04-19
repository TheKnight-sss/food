import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/functions/image_uploader.dart';
import 'package:food/features/food/models/product_model.dart';
import 'package:food/features/food/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  ProductModel? productModel;
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  List<String> allCategories = [];

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final categController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //! add item
  Future<void> addItem([File? product]) async {
    if (!formKey.currentState!.validate()) return;

    if (product == null) {
      emit(AddItemError("Please select product image"));
      return;
    }
    try {
      emit(ProductLoading());
      String? imageUrl = await updateImageToCloudinary(product);

       productModel = ProductModel(
        id: "",
        name: nameController.text,
        price: double.parse(priceController.text),
        description: descController.text,
        imageUrl: imageUrl!,
        category: categController.text,
      );

      await FirebaseFirestore.instance
          .collection("products")
          .add(productModel!.toJson());
      emit(ProductAdded());
    } catch (e) {
      emit(AddItemError(e.toString()));
    }
  }

  Future<void> updateItem(String id, [File? product]) async {
    if (!formKey.currentState!.validate()) return;

    try {
      emit(ProductLoading());
      String? imageUrl = product != null ? await updateImageToCloudinary(product) : productModel!.imageUrl;

       productModel = ProductModel(
        id: id,
        name: nameController.text,
        price: double.parse(priceController.text),
        description: descController.text,
        imageUrl: imageUrl!,
        category: categController.text,
      );

      await FirebaseFirestore.instance
          .collection("products")
          .doc(id)
          .update(productModel!.toJson());
      emit(ProductAdded());
    } catch (e) {
      emit(AddItemError(e.toString()));
    }
  }
   
  Future<void> getProducts({String? category}) async {
  // Only show loading on initial load, not on category filter
  if (allProducts.isEmpty) {
    emit(ProductLoading());
  }

  try {
    // Only fetch from Firebase on initial load
    if (allProducts.isEmpty) {
      final snapshot = await FirebaseFirestore.instance.collection("products").get();

      allProducts = snapshot.docs
          .map((e) {
            final data = e.data();
            data['id'] = e.id; // ensure id is set from document
            return ProductModel.fromJson(data);
          })
          .toList();



      allCategories = snapshot.docs
          .map((e) => (e.data())["category"] as String)
          .toSet()
          .toList();

      allCategories.insert(0, "All");
    }

    if (category != null && category != "All") {
      filteredProducts = allProducts.where((p) => p.category == category).toList();
    } else {
      filteredProducts = allProducts;
    }

    
    emit(ProductLoaded(filteredProducts, allCategories));
  } catch (e) {
    emit(AddItemError(e.toString()));
  }
}

  Future<void> deleteItem(String id) async {
    try {
      emit(ProductLoading());
      await FirebaseFirestore.instance.collection("products").doc(id).delete();
      allProducts.removeWhere((p) => p.id == id);
      emit(ProductLoaded(allProducts, allCategories));
    } catch (e) {
      emit(AddItemError(e.toString()));
    }
  }

  void searchProducts(String query) {
  if (query.isEmpty) {
    filteredProducts = allProducts;
  } else {
    filteredProducts = allProducts.where((product) {
      return product.name
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }

  emit(ProductLoaded(filteredProducts, allCategories));
}

}
