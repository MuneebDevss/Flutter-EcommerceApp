import 'package:flutter/material.dart';

class SpacedText extends StatelessWidget {
  const SpacedText({
    super.key, required this.firstText, required this.secondText, required this.firstStyle, required this.secondStyle, this.onTap,
  });
  final String firstText;
  final String secondText;
  final TextStyle? firstStyle,secondStyle;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(firstText,style: firstStyle,),
        TextButton(onPressed: onTap, child: Text(secondText,style: secondStyle,),)
      ],
    );
  }
}
