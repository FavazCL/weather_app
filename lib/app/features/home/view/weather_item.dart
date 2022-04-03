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
    final responsive = Responsive.of(context);

    return responsive.isPortrait
        ? WeatherItemPortrait(
            weather: weather,
            isToday: isToday,
            onTap: onTap,
          )
        : WeatherItemLandscape(
            weather: weather,
            isToday: isToday,
            onTap: onTap,
          );
  }
}

class WeatherItemPortrait extends StatelessWidget {
  const WeatherItemPortrait({
    Key? key,
    required this.weather,
    required this.isToday,
    required this.onTap,
  }) : super(key: key);

  final ConsolidatedWeather weather;
  final bool isToday;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minWidth: responsive.wp(25)),
        margin: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Palette.purpleLight,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: responsive.hp(2),
            horizontal: responsive.wp(2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${isToday ? 'Today' : FormatDate.getJustDayOfWeek(weather.applicableDate)}',
                style: TextStyle(
                  fontSize: responsive.dp(1.6),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: responsive.hp(2)),
              WeatherStateImage(
                height: responsive.hp(5),
                state: weather.weatherStateName.toLowerCase(),
              ),
              SizedBox(height: responsive.hp(2)),
              Text(
                '${weather.minTemp.toInt()}°/${weather.maxTemp.toInt()}°',
                style: TextStyle(
                  fontSize: responsive.dp(1.6),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherItemLandscape extends StatelessWidget {
  const WeatherItemLandscape({
    Key? key,
    required this.weather,
    required this.isToday,
    required this.onTap,
  }) : super(key: key);

  final ConsolidatedWeather weather;
  final bool isToday;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minWidth: responsive.wp(15)),
        margin: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Palette.purpleLight,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: responsive.hp(2),
            horizontal: responsive.wp(2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${isToday ? 'Today' : FormatDate.getJustDayOfWeek(weather.applicableDate)}',
                style: TextStyle(
                  fontSize: responsive.dp(1.6),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: responsive.hp(3)),
              WeatherStateImage(
                height: responsive.hp(10),
                state: weather.weatherStateName.toLowerCase(),
              ),
              SizedBox(height: responsive.hp(3)),
              Text(
                '${weather.minTemp.toInt()}°/${weather.maxTemp.toInt()}°',
                style: TextStyle(
                  fontSize: responsive.dp(1.6),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
