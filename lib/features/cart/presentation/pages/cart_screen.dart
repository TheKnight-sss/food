import 'package:flutter/material.dart';
import 'package:food/components/inputs/custom_text_field.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cartbg2,
      bottomNavigationBar: Container(
        height: 310,
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "DELIVERY ADDRESS",
                  style: Style.body.copyWith(color: AppColors.icon2),
                ),
                Gap(10),
                CustomTextField(
                  hint: "Enter your address",
                  color: AppColors.icon2,                  
                ),
                Gap(30),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
