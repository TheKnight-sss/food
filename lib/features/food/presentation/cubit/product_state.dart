import 'package:food/features/food/models/product_model.dart';

class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductAdded extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final List<String> categories;
  ProductLoaded(this.products, this.categories);
}

class AddItemError extends ProductState {
  final String message;
  AddItemError(this.message);
}

