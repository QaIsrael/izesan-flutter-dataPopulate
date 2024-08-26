import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'app_text.dart';

class izsTextButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String text;

  const izsTextButton({
    Key? key,
    required this.width,
    required this.height,
    this.color = AppColors.primaryColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: text,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
      size: 14,
    );
  }
}
