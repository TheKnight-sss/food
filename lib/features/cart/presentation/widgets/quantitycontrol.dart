import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gap/gap.dart';

class quantitycontrol extends StatelessWidget {
  const quantitycontrol({super.key, required this.item});

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.read<CartCubit>().removeItem(item.product);
          },
          child: Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 16),
          ),
        ),
        const Gap(20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
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
              style: Style.regular.copyWith(color: Colors.white),
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
