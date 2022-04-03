import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ui_kit/ui_kit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(color: Palette.background),
          Center(
            child: LottieBuilder.asset(
              'assets/animations/loading.json',
              package: 'ui_kit',
            ),
          )
        ],
      ),
    );
  }
}
