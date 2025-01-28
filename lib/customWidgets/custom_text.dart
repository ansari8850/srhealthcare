import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDirection? textDirection;

   const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.overflow,
    this.textAlign,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: decoration,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        height: height,
      ),
      overflow: overflow,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}
