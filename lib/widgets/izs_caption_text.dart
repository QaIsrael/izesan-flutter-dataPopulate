import 'package:flutter/material.dart';

class IzsCaptionText extends StatelessWidget {
  final FontWeight? fontWeight;
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextTheme? textTheme;
  final TextOverflow? overFlow;
  final int? maxLines;

  const IzsCaptionText({
    Key? key,
    this.fontWeight,
    this.textAlign = TextAlign.left,
    required this.text,
    this.textTheme,
    this.overFlow,
    this.maxLines,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overFlow,
      softWrap: false,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
