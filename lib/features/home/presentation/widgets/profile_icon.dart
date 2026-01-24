import 'package:flutter/material.dart';
import 'package:food/core/utils/colors.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
    required this.imageUrl,
    required this.size,
  });

  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: AppColors.white,
      backgroundImage:
          imageUrl != null && imageUrl!.isNotEmpty
              ? NetworkImage(imageUrl!)
              : null,
      child:
          imageUrl == null || imageUrl!.isEmpty
              ? Icon(
                  Icons.person,
                  size: size,
                  color: AppColors.primcolor,
                )
              : null,
    );
  }
}
