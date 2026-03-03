import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/core/constants/app_images.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navItem(AppImages.window,0,26,26,true),
            _navItem(AppImages.list,1,26,26,true),
            GestureDetector(
              onTap: () {
                pushTo(context, Routes.addItem);                
              },
              child: ClipOval(
                child: SvgPicture.asset(AppImages.add),
              ),
            ),
            _navItem(AppImages.bell,3,26,26,true),
            _navItem(AppImages.user2,4,26,26,true),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String icon,int index,double w,double h,bool useColor){
    final isActive = currentIndex == index;
    return GestureDetector(
      onTap: (){onTap(index);},
      child: SvgPicture.asset(icon,
      width: w,
      height: h,
      colorFilter: useColor ? ColorFilter.mode(
        isActive ? AppColors.primcolor : AppColors.icon3,
        BlendMode.srcIn,) : null,
      )
    );

  }
}
