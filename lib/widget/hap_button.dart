import 'package:flutter/cupertino.dart';

import '../utils/constants/app_styles.dart';

class Cmnbutton extends StatelessWidget {
  const Cmnbutton(
      {super.key,
      this.width,
      this.height,
      this.fontSize,
      this.bgColor,
      required this.textColor,
      required this.borderColor,
      this.borderRadius,
      required this.msg,
      required this.fontWeight,
      required this.fontStyle,
      required this.useRiveWidget,
      this.riveChild,
      required this.onClick});

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
          color: bgColor ?? Styles.primaryColor,
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: borderColor),
        ),
        alignment: Alignment.center,
        child: useRiveWidget
            ? riveChild
            : NymText(
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
