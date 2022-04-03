import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:utils/utils.dart';


class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    required this.location,
    required this.date,
    required this.temperature,
    required this.isCelsius,
  }) : super(key: key);

  final String location;
  final DateTime date;
  final double temperature;
  final bool isCelsius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          FormatDate.getDayOfWeek(date),
          style: const TextStyle(fontSize: 16, color: Palette.grey),
        ),
        const SizedBox(height: 5),
        Text(
          location,
          style: const TextStyle(
            fontSize: 18,
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '${temperature.toInt()} ${isCelsius ? '°C' : '°F'}',
          style: const TextStyle(
            fontSize: 24,
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
