import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/features/cart/models/cart_model.dart';
import 'package:food/features/cart/presentation/cubit/cart_state.dart';
import 'package:food/features/food/models/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  void addToCart(ProductModel product) {
    final index =
        _items.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(CartItemModel(product: product));
    }

    emit(CartUpdated(_items, _calculateTotal()));
  }

  double _calculateTotal() {
    return _items.fold(
        0, (sum, item) => sum + item.totalPrice);
  }
}