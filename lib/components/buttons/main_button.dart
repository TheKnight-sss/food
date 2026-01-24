import 'package:flutter/material.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.txt,
    this.onpressed,
    this.width,
    this.height,
    this.txtcolor,
    this.bgcolor = AppColors.primcolor,
  });

  final String txt;
  final Function()? onpressed;
  final double? width;
  final double? height;
  final Color? txtcolor;
  final Color bgcolor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 62,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onpressed,
        child: Text(txt,
        style: Style.body.copyWith(color: AppColors.white),),
      ),
    );
  }
}
