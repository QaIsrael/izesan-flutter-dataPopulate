import 'package:flutter/material.dart';
import '../utils/helper_widgets.dart';

class ColoredCard extends StatelessWidget {
  final Color borderColor;
  final Color cardColor;
  final double borderRadius;
  final Widget child;
  final double border;
  final double? margin;

  const ColoredCard(
      {Key? key,
      this.cardColor = Colors.transparent,
      required this.borderRadius,
      required this.borderColor,
      required this.child,
      required this.border,
      this.margin = 4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: margin!, vertical: margin!),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: border),
        boxShadow: [generateBoxShadow(context)],
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}