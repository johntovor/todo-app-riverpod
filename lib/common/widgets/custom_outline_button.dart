import 'package:flutter/material.dart';

import './app_style.dart';
import './reusable_text.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton(
      {Key? key,
      this.onTap,
      required this.width,
      required this.height,
      required this.color,
      this.color2,
      required this.text})
      : super(key: key);

  final void Function()? onTap;
  final double width;
  final double height;
  final Color color;
  final Color? color2;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          border: Border.all(width: 1.0, color: color),
        ),
        child: Center(
            child: ReusableText(
          text: text,
          style: appStyle(18.0, color, FontWeight.bold),
        )),
      ),
    );
  }
}
