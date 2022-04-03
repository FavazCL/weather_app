import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Column(
      children: [
         Text(
          'Daily',
          style: TextStyle(
            fontSize: responsive.dp(2),
            color: Palette.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: responsive.hp(1)),
        Text(
          'Weather',
          style: TextStyle(
            fontSize: responsive.dp(2.8),
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
