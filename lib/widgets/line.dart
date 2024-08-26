import 'package:flutter/material.dart';

import '../utils/colors.dart';

class Line extends StatelessWidget {
  final double width;
  final double? height;
  final Color color;

  const Line(
      {Key? key,
      required this.width,
      this.height = 0.2,
      this.color = AppColors.captionColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(height: height, width: width, color: color),
    );
  }
}
