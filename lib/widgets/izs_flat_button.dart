import 'dart:async';

import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'app_text.dart';

class IzsFlatButton extends StatelessWidget {
  final bool isResponsive;
  final double width;
  final double height;
  final double borderWidth;
  final Color borderColor;
  final Color color;
  final Function onPressed;
  final String text;
  final double textSize;
  final Color textColor;
  final double borderRadius;
  final GlobalKey<FormState>? formKey;
  final bool isLoading;
  final bool isEnabled;

  const IzsFlatButton({
    Key? key,
    this.width = 120,
    required this.height,
    this.borderWidth = 0,
    required this.borderColor,
    this.formKey,
    this.textColor = Colors.white,
    this.color = AppColors.primaryColor,
    required this.text,
    required this.textSize,
    this.isResponsive = false,
    required this.onPressed,
    required this.borderRadius,
    this.isLoading = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: debounce(() => onPressed(), const Duration(milliseconds: 300)),
      child: Container(
        width: isResponsive == true ? double.maxFinite : width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: color,
            border: Border.all(width: borderWidth, color: borderColor)),
        child: isLoading
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 1,
              ),
            ),
            addHorizontalSpace(8),
            AppText(text: 'Please wait...', color: AppColors.primaryColor, size: textSize)
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [AppLargeText(text: text, color: textColor, size: textSize)],
        ),
      ),
    );
  }
}

 debounce(Function func, Duration duration) {
  Timer? timer;
  return () {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(duration, () {
      func.call(); // Null check before calling the function
    });
  };

}