import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';

class UpBar extends StatelessWidget {
  const UpBar({
    super.key,
    required this.user,
    required this.color,
    required this.icon,
  });

  final Text? user;
  final Color color;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: ClipOval(
          child: Container(
            color: color,
            child: SvgPicture.asset(
              AppImages.profile,
              width: 24,
              height: 54,
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(
          user?.data ?? "",
          style: Style.title.copyWith(color: AppColors.primcolor),
        ),
        subtitle: Text(
          "Welcome",
          style: Style.regular.copyWith(color: AppColors.txtcolor),
        ),
        trailing: ClipOval(
          child: Container(
            color: AppColors.icon,
            width: 45,
            height: 49,
            child: icon,
          ),
        ),
      ),
    );
  }
}
