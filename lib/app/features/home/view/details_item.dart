import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class DetailsItem extends StatelessWidget {
  const DetailsItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final num value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Palette.black),
        ),
        const SizedBox(height: 5),
        Text(
          '${value.toInt()}',
          style: const TextStyle(
            fontSize: 24,
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
