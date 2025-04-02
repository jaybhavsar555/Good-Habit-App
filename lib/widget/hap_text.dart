import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants/app_styles.dart';

class HapText extends StatelessWidget {
  HapText({
    super.key,
    required this.msg,
    this.fontSize,
    this.overflow = TextOverflow.visible,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.w400,
    this.fontStyle = FontStyle.normal,
    this.textDecoration = TextDecoration.none,
    this.maxLines = 1,
    Color? textColor, // Nullable parameter
  }) : textColor =
            textColor ?? Styles.textColor; // Assign default in initializer list

  String msg;
  double? fontSize;
  FontWeight fontWeight;
  FontStyle fontStyle;
  Color textColor = Colors.black;
  TextDecoration textDecoration;
  TextAlign textAlign;
  TextOverflow overflow;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: textDecoration,
        color: textColor,
      ),
    );
  }
}
