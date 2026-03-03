import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/features/food/presentation/cubit/product_cubit.dart';
import 'package:food/features/food/presentation/cubit/product_state.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
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
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 321,
                decoration: BoxDecoration(),
                child:Stack(
                  children: [],
                ),
              ),
            ],
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