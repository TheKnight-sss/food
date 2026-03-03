import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/features/admin/presentation/widget/food_card.dart';
import 'package:food/features/food/presentation/cubit/product_cubit.dart';
import 'package:food/features/food/presentation/cubit/product_state.dart';
import 'package:gap/gap.dart';

class AdminMenuScreen extends StatefulWidget {
  const AdminMenuScreen({super.key});

  @override
  State<AdminMenuScreen> createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<AdminMenuScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductLoaded) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: ListView.separated(
              itemCount: state.products.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final product = state.products[index];
            
                return FoodCard(
                  imageUrl: product.imageUrl,
                  name: product.name,
                  category: product.category,
                  price: product.price,
                );
              }, separatorBuilder: (BuildContext context, int index) { return const Gap(20); },
            ),
          );
        }

        if (state is AddItemError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
