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
    final responsive = Responsive.of(context);

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: responsive.dp(1.6), color: Palette.black),
        ),
        SizedBox(height: responsive.hp(1)),
        Text(
          '${value.toInt()}',
          style: TextStyle(
            fontSize: responsive.dp(2.4),
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
