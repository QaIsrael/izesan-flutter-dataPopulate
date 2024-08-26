import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLargeText extends StatelessWidget {
  final double size;
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextTheme? textTheme;
  final TextOverflow? overflow;
  final int? maxLines;

  const AppLargeText(
      {Key? key,
      this.size = 24,
      required this.text,
      this.textAlign = TextAlign.left,
      this.textTheme,
      this.overflow,
      this.maxLines,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      textScaler: TextScaler.noScaling,
      style: GoogleFonts.nunitoSans(
        color: color,
        fontSize: size,
        textStyle: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
