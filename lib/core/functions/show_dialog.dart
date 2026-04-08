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
        child: Container(
          width: 220,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                "assets/images/Loading.json",
                delegates: LottieDelegates(
                  values: [
                    ValueDelegate.color(
                      const ['**'],
                      value: AppColors.primcolor,
                    ),
                  ],
                ),
                width: 120,
                height: 120,
                fit: BoxFit.contain,
                repeat: true,
              ),
              const SizedBox(height: 12),
              Text('Loading...', style: Style.body.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );
    },
  );
}
