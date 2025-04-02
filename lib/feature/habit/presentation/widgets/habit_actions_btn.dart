import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HabitActionBtn extends StatelessWidget {
  const HabitActionBtn(
      {super.key,
      required this.icon,
      required this.toolTip,
      required this.onPressed});

  final IconData icon;
  final String toolTip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(width: 2.7, color: Colors.white),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        tooltip: toolTip,
        onPressed: onPressed,
      ),
    );
  }
}
