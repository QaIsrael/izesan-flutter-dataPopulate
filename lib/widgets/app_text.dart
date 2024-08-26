import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final double size;
  final FontWeight? fontWeight;
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextTheme? textTheme;
  final TextOverflow? overflow;
  final int? maxLines;

  const AppText({
    Key? key,
    this.size = 16.0,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.left,
    required this.text,
    this.textTheme,
    this.overflow,
    this.maxLines,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: true,
      maxLines: maxLines,
      textScaler: TextScaler.noScaling,
      style: GoogleFonts.nunitoSans(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        textStyle: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
