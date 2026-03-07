import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gap/gap.dart';

class quantitycontrol extends StatelessWidget {
  const quantitycontrol({super.key, required this.item});

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.read<CartCubit>().removeItem(item.product);
          },
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 16),
          ),
        ),
        const Gap(20),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                context.read<CartCubit>().decreaseQuantity(item.product);
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.remove, color: Colors.white, size: 14),
              ),
            ),
            const Gap(20),
            Text(
              '${item.quantity}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            GestureDetector(
              onTap: () {
                context.read<CartCubit>().addToCart(item.product);
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
