import 'package:flutter/material.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:gap/gap.dart';

class FoodCard extends StatefulWidget {
  const FoodCard({
    super.key,
    required this.imageUrl,
    this.name,
    this.category,
    this.price,
  });
  final String? imageUrl;
  final String? name;
  final String? category;
  final double? price;

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Container(
            height: 102,
            width: 102,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(widget.imageUrl ?? "", fit: BoxFit.fill),
            ),
          ),
          Gap(12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name ?? "Food Name",style: Style.fdname),
              Gap(11),
              Container(
                height: 24,
                width: 88,
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    widget.category ?? "Food Category",
                    style: Style.body.copyWith(color: AppColors.primcolor),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_horiz),
                onSelected: (value) {
                  if (value == 'edit') {
                    // TODO: edit product
                  } else if (value == 'delete') {
                    // TODO: delete product
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
              Gap(8),
              Text("\$${widget.price ?? 20.00}"),
            ],
          ),
        ],
      ),
    );
  }
}
