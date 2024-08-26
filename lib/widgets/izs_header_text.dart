import 'package:flutter/material.dart';

class IzsHeaderText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextTheme? textTheme;
  final TextOverflow? overFlow;
  final int? maxLines;

  const IzsHeaderText({
    Key? key,
    this.textAlign = TextAlign.left,
    required this.text,
    this.textTheme,
    this.overFlow,
    this.maxLines,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        overflow: overFlow,
        softWrap: false,
        maxLines: maxLines,
        textScaler: TextScaler.noScaling,
        style: Theme.of(context).textTheme.headlineSmall);
  }
}
