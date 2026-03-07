import 'package:flutter/material.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:gap/gap.dart';

class Counter extends StatelessWidget {
  const Counter({
    super.key,
    required this.count,
    required this.label,
  });

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 115,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count.toString(),
            style: Style.Extra,
          ),
          Gap(5),
          Text(
            label,
            style: Style.body.copyWith(color: AppColors.txt2color),
          ),
        ],
      ),
    );
  }
}
