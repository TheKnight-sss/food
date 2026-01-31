import 'package:flutter/material.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/features/auth/models/admin_model.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
    required this.imageUrl,
    required this.size, required this.admin,
    
  });

  final String? imageUrl;
  final double size;
  final AdminModel admin;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: AppColors.white,
      child:
          imageUrl == null || imageUrl!.isEmpty
              ? Icon(
                  Icons.person,
                  size: size,
                  color: AppColors.primcolor,
                  
                )
              : Image.network(admin.image!),
    );
  }
}
