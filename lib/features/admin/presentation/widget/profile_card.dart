import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:gap/gap.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key, required this.txt, this.color, required this.asset, required this.isOk,
  });

  final String txt;
  final Color? color;
  final String asset;
  final bool isOk ;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 48,
          width: 48,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: (isOk == true) ? SvgPicture.asset(
                asset,
                colorFilter: ColorFilter.mode(
                  color?? AppColors.icon,
                  BlendMode.srcIn,
                ),
                height: 24,
                width: 24,
              ) : Image.asset(
                asset,
                color: color?? AppColors.icon,
                height: 24,
                width: 24,
              ),
            ),
          ),
        ),
        Gap(13),
        Text(txt, style: Style.regular),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios_sharp,
          color: AppColors.arrow,
        ),
      ],
    );
  }
}
