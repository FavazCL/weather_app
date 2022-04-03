import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:utils/utils.dart';
import 'package:weather_api/weather_api.dart' show ConsolidatedWeather;

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    Key? key,
    required this.weather,
    required this.onTap,
    this.isToday = false,
  }) : super(key: key);

  final ConsolidatedWeather weather;
  final bool isToday;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 100),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Palette.purpleLight,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${isToday ? 'Today' : FormatDate.getJustDayOfWeek(weather.applicableDate)}',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(height: 15),
              WeatherStateImage(
                height: 50,
                state: weather.weatherStateName.toLowerCase(),
              ),
              const SizedBox(height: 15),
              Text(
                '${weather.minTemp.toInt()}°/${weather.maxTemp.toInt()}°',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
