import 'package:flutter/material.dart';
import 'package:food/components/inputs/custom_text_field.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:food/features/cart/presentation/cubit/cart_state.dart';
import 'package:food/features/cart/presentation/widgets/quantitycontrol.dart';
import 'package:gap/gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/features/orders/models/order_model.dart';
import 'package:food/features/orders/presentation/cubit/order_cubit.dart';
import 'package:food/features/orders/presentation/cubit/order_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late TextEditingController _deliveryAddressController;

  @override
  void initState() {
    super.initState();
    _deliveryAddressController = TextEditingController();
  }

  @override
  void dispose() {
    _deliveryAddressController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder(List<dynamic> items, double total) async {
    // Validate delivery address
    if (_deliveryAddressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter delivery address')),
      );
      return;
    }

    // Get current user
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login first')),
      );
      return;
    }

    // Create order items from cart items
    final orderItems = items.map((cartItem) {
      return OrderItemModel(
        product: cartItem.product,
        quantity: cartItem.quantity,
      );
    }).toList();

    // Call the cubit to place order
    context.read<OrderCubit>().placeOrder(
      items: orderItems,
      deliveryAddress: _deliveryAddressController.text.trim(),
      totalAmount: total,
      customerUserId: user.uid,
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        } else if (state is OrderSuccess) {
          // Close loading dialog
          Navigator.pop(context);

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );

          // Clear cart
          context.read<CartCubit>().clearCart();

          // Clear address field
          _deliveryAddressController.clear();

          // Navigate back
          Navigator.pop(context);
        } else if (state is OrderFailure) {
          // Close loading dialog
          Navigator.pop(context);

          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.cartbg2,
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            List items = [];
            double total = 0;
            if (state is CartUpdated) {
              items = state.items;
              total = state.total;
            }
            return Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const Gap(12),
                        Text(
                          'Cart',
                          style: Style.title.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(20),
              // Cart Items List
              if (items.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'Your cart is empty',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.product.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Gap(12),
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: Style.title.copyWith(color: Colors.white),
                                  ),
                                  const Gap(12),
                                  Text(
                                    '\$${item.product.price}',
                                    style: Style.regular.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            // Quantity Controls and Remove
                            quantitycontrol(item: item),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              // Bottom Section
              if (items.isNotEmpty)
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DELIVERY ADDRESS',
                        style: Style.body.copyWith(color: AppColors.icon2),
                      ),
                      const Gap(8),
                      CustomTextField(
                        hint: "Enter delivery address",
                        controller: _deliveryAddressController,
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL:',
                            style: Style.title.copyWith(color: AppColors.icon2),
                          ),
                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: Style.title,
                          ),
                        ],
                      ),
                      const Gap(16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _placeOrder(items, total);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF9500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'PLACE ORDER',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
          },
        ),
      ),
    );
  }
}
