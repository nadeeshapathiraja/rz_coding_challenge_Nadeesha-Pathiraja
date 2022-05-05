import 'package:flutter/material.dart';
import 'package:push_notification/utils/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    this.fontSize = 15,
    this.color = primaryTxtColor,
    this.fontWeight,
    this.textAlign,
    this.textOverflow = TextOverflow.ellipsis,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
