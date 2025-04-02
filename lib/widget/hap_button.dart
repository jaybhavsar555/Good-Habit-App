import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:good_habit_app/widget/hap_text.dart';

import '../utils/constants/app_styles.dart';

class HapButton extends StatelessWidget {
  const HapButton(
      {super.key,
      this.width,
      this.height = 48,
      this.bgColor,
      this.borderColor = Colors.transparent,
      this.borderRadius,
      required this.onClick,
      required this.msg,
      this.textColor = Colors.white,
      this.fontStyle = FontStyle.normal,
      this.fontWeight = FontWeight.w500,
      this.fontSize = 18,
      this.useRiveWidget = false,
      this.riveChild});

  final double? width, height;
  final double? fontSize;
  final Color? bgColor;
  final Color textColor, borderColor;
  final BorderRadius? borderRadius;
  final String msg;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final bool useRiveWidget;
  final Widget? riveChild;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: width?.w,
        height: height!.h,
        decoration: BoxDecoration(
          color: bgColor ?? Styles.btnColor,
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: borderColor),
        ),
        alignment: Alignment.center,
        child: useRiveWidget
            ? riveChild
            : HapText(
                msg: msg,
                fontSize: fontSize,
                fontWeight: fontWeight,
                textColor: textColor,
                fontStyle: fontStyle,
              ),
      ),
    );
  }
}
