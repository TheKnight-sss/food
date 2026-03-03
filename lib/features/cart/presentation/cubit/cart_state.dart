import 'package:food/features/cart/models/cart_model.dart';

class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<CartItemModel> items;
  final double total;

  CartUpdated(this.items, this.total);
}