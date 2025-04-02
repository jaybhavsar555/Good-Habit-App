import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HabitActionBtnRow extends StatelessWidget {
  const HabitActionBtnRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: buttons
            .map((button) => _buildIconButton(button.$1, button.$2, button.$3))
            .toList(),
      ),
    );
  }
}
