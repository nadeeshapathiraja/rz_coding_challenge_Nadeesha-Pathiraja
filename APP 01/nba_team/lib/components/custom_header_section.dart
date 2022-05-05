import 'package:flutter/material.dart';
import 'package:nba_team/components/custom_text.dart';
import 'package:nba_team/utils/constants.dart';

class CustomHeaderSection extends StatelessWidget {
  const CustomHeaderSection({
    Key? key,
    required this.size,
    required this.text,
  }) : super(key: key);

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          Constants.imageAsset("header.png"),
          width: size.width,
          fit: BoxFit.fitWidth,
        ),
        CustomText(
          text: text,
          fontSize: 50,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
