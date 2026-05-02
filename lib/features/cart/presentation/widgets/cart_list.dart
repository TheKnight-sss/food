import 'package:flutter/material.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/cart/presentation/widgets/quantitycontrol.dart';
import 'package:gap/gap.dart';

class CartList extends StatelessWidget {
  const CartList({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 117,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.product.imageUrl,
              width: 136,
              height: 117,
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
                  style: Style.title.copyWith(
                    color: Colors.white,
                  ),
                ),
                const Gap(12),
                Text(
                  '\$${item.product.price}',
                  style: Style.regular.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Quantity Controls and Remove
          quantitycontrol(item: item),
        ],
      ),
    );
  }
}
