import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/components/up_bar.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/customer/presentation/widgets/product_card.dart';
import 'package:food/features/food/presentation/cubit/product_cubit.dart';
import 'package:food/features/food/presentation/cubit/product_state.dart';
import 'package:gap/gap.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  User? user;
  int selectedIndex = 0;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
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
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gap(30),
                    UpBar(
                      user: Text(user?.displayName ?? ""),
                      icon: Icon(Icons.shopping_bag_outlined),
                      color: AppColors.white,
                    ),
                    Gap(55),
                    TextField(
                      onChanged: (value) {
                        context.read<ProductCubit>().searchProducts(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search dishes",
                        hintStyle: TextStyle(color: AppColors.txtcolor2),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            width: 20,
                            height: 20,
                            AppImages.search,
                            color: AppColors.icon2,
                          ),
                        ),
                      ),
                    ),
                    Gap(32),
                    Row(children: [Text("All Categories", style: Style.title)]),
                    Gap(20),
                    SizedBox(
                      height: 60,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final cat = state.categories[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                              context.read<ProductCubit>().getProducts(
                                category: cat,
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: 103,
                              height: 60,
                              decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? AppColors.categcolor
                                    : AppColors.accentcolor3,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Text(cat, style: Style.fdname),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(7),
                        itemCount: state.categories.length,
                      ),
                    ),
                    Gap(30),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(product: product,
                        
                          );
                      },
                    )
                  ],
                ),
              ),
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
