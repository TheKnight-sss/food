import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class UpBar extends StatelessWidget {
  const UpBar({
    super.key,
    this.user,
    required this.icon,
    this.onIconTap,
    this.onpicTap,
    this.icon1,
    required this.isActive,
    this.title,
  });

  final bool isActive;

  final Text? user;
  final String? title;
  final Widget? icon;
  final Widget? icon1;
  final VoidCallback? onIconTap;
  final VoidCallback? onpicTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            GestureDetector(
              onTap: onpicTap,
              child: ClipOval(
                child: Container(
                  width: 45,
                  height: 45,
                  color: AppColors.accentcolor4,
                  child: Center(child: isActive ? prexIcon() : icon1),
                ),
              ),
            ),
            const Gap(18),
            if (isActive)
              Expanded(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.data ?? "",
                          style: Style.title.copyWith(color: AppColors.primcolor),
                        ),
                        Text(
                          "Welcome",
                          style: Style.regular.copyWith(
                            color: AppColors.txtcolor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(onTap: onIconTap, child: cartIcon()),
                  ],
                ),
              )
            else
              Text(title ?? "", style: Style.title),
          ],
        ),
      ),
    );
  }

  //! methods for Icons
  ClipOval cartIcon() {
    return ClipOval(
      child: Container(
        color: AppColors.icon,
        width: 45,
        height: 45,
        child: icon,
      ),
    );
  }

  SvgPicture prexIcon() {
    return SvgPicture.asset(AppImages.profile, width: 16, height: 20);
  }
}
