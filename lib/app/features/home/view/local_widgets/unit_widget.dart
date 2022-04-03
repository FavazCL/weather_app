import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class UnitWidget extends StatelessWidget {
  const UnitWidget({
    Key? key,
    required this.isCelsius,
    required this.onPressed,
  }) : super(key: key);

  final bool isCelsius;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ContainerBase(
      child: IconButton(
        onPressed: onPressed,
        icon: Image.asset(
          isCelsius
              ? 'assets/images/celsius.png'
              : 'assets/images/farenheit.png',
          package: 'ui_kit',
        ),
      ),
    );
  }
}
