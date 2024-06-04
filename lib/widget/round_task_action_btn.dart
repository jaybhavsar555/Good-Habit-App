import 'package:flutter/material.dart';

class RoundTaskActionBtn extends StatelessWidget {
  final icon;

  const RoundTaskActionBtn({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(width: 2.7, color: Colors.white),
        ),
        child: IconButton(onPressed: () {}, icon: icon),
      );
    });
  }
}
