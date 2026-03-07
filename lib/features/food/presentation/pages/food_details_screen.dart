import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/components/up_bar.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/food/models/product_model.dart';
import 'package:gap/gap.dart';

class FoodDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const FoodDetailsScreen({super.key, required this.product});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cartbg2,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Product Image
            Center(
              child: Container(
                height: 210,
                width: 327,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Gap(32),
            // Product Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    widget.product.name,
                    style: Style.heading.copyWith(color: Colors.white),
                  ),
                  const Gap(16),
                  // Product Price
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: Style.title.copyWith(
                      color: const Color(0xFFFF9500),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(24),
                  // Product Description
                  Text(
                    'Description',
                    style: Style.title.copyWith(color: Colors.white),
                  ),
                  const Gap(12),
                  Text(
                    widget.product.description,
                    style: Style.body.copyWith(
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}