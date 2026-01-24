import 'package:flutter/material.dart';
import 'package:food/core/utils/colors.dart';

class AdminMenuScreen extends StatelessWidget {
  const AdminMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 271,
            decoration: const BoxDecoration(
              color: AppColors.primcolor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              
            ),  
          )
        ],
      ),
    );
  }
}