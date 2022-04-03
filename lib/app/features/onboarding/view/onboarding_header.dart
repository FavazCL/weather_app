import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
         Text(
          'Daily',
          style: TextStyle(
            fontSize: 24,
            color: Palette.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Weather',
          style: TextStyle(
            fontSize: 28,
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
