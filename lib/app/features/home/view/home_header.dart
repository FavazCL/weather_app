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
    final responsive = Responsive.of(context);

    return responsive.isPortrait
        ? HomeHeaderPortrait(
            location: location,
            date: date,
            temperature: temperature,
            isCelsius: isCelsius,
          )
        : HomeHeaderLandscape(
            location: location,
            date: date,
            temperature: temperature,
            isCelsius: isCelsius,
          );
  }
}

class HomeHeaderPortrait extends StatelessWidget {
  const HomeHeaderPortrait({
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
    final responsive = Responsive.of(context);

    return Column(
      children: [
        Text(
          FormatDate.getDayOfWeek(date),
          style: TextStyle(fontSize: responsive.dp(1.6), color: Palette.grey),
        ),
        SizedBox(height: responsive.hp(1)),
        Text(
          location,
          style: TextStyle(
            fontSize: responsive.dp(1.8),
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: responsive.hp(1)),
        Text(
          '${temperature.toInt()} ${isCelsius ? '°C' : '°F'}',
          style: TextStyle(
            fontSize: responsive.dp(3),
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class HomeHeaderLandscape extends StatelessWidget {
  const HomeHeaderLandscape({
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
    final responsive = Responsive.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: responsive.hp(2)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                FormatDate.getDayOfWeek(date),
                style: TextStyle(
                  fontSize: responsive.dp(1.6),
                  color: Palette.grey,
                ),
              ),
              SizedBox(width: responsive.wp(2)),
              Text(
                location,
                style: TextStyle(
                  fontSize: responsive.dp(1.8),
                  color: Palette.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.hp(2)),
          Text(
            '${temperature.toInt()} ${isCelsius ? '°C' : '°F'}',
            style: TextStyle(
              fontSize: responsive.dp(3),
              color: Palette.black,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
