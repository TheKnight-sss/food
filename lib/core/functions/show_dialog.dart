import 'package:flutter/material.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:lottie/lottie.dart';

enum Dialogs { error, success, warring }

void showMyDialog(
  BuildContext context,
  String message, {
  Dialogs type = Dialogs.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: Style.body),
      backgroundColor: type == Dialogs.error
          ? Colors.red
          : type == Dialogs.success
          ? AppColors.primcolor
          : AppColors.accentcolor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 0,
    ),
  );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColors.darkColor.withValues(alpha: 7),
    builder: (context) {
      return Center(
        child: Lottie.asset(
          "assets/images/Loading.json",
          delegates: LottieDelegates(
            values: [
              ValueDelegate.color(
                const ['**'],
                value: AppColors.primcolor,
              ),
            ],
          ),
          width: 180,
          height: 180,
          fit: BoxFit.contain,
          repeat: true),
      );
    },
  );
}
