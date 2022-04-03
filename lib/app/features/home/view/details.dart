import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:weather_api/weather_api.dart' show ConsolidatedWeather;
import 'package:weather_app/app/features/home/view/details_item.dart';

class Details extends StatelessWidget {
  const Details({Key? key, required this.consolidatedWeather})
      : super(key: key);

  final ConsolidatedWeather consolidatedWeather;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return responsive.isPortrait
        ? DetailsPortrait(consolidatedWeather: consolidatedWeather)
        : DetailsLandscape(consolidatedWeather: consolidatedWeather);
  }
}

class DetailsPortrait extends StatelessWidget {
  const DetailsPortrait({Key? key, required this.consolidatedWeather})
      : super(key: key);

  final ConsolidatedWeather consolidatedWeather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        WeatherStateImage(
          state: consolidatedWeather.weatherStateName.toLowerCase(),
        ),
        const SizedBox(height: 40),
        Text(
          consolidatedWeather.weatherStateName,
          style: const TextStyle(
            fontSize: 40,
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DetailsItem(
                title: 'Humidity',
                value: consolidatedWeather.humidity,
              ),
              VerticalDivider(
                color: Palette.black.withOpacity(0.2),
                thickness: 1,
              ),
              DetailsItem(
                title: 'Pressure',
                value: consolidatedWeather.airPressure,
              ),
              VerticalDivider(
                color: Palette.black.withOpacity(0.2),
                thickness: 1,
              ),
              DetailsItem(
                title: 'Wind',
                value: consolidatedWeather.windSpeed,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DetailsLandscape extends StatelessWidget {
  const DetailsLandscape({Key? key, required this.consolidatedWeather})
      : super(key: key);

  final ConsolidatedWeather consolidatedWeather;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            WeatherStateImage(
              state: consolidatedWeather.weatherStateName.toLowerCase(),
            ),
            const SizedBox(height: 20),
            Text(
              consolidatedWeather.weatherStateName,
              style: const TextStyle(
                fontSize: 40,
                color: Palette.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(width: 40),
        IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DetailsItem(
                title: 'Humidity',
                value: consolidatedWeather.humidity,
              ),
              Divider(
                color: Palette.black.withOpacity(0.2),
                thickness: 1,
              ),
              DetailsItem(
                title: 'Pressure',
                value: consolidatedWeather.airPressure,
              ),
              Divider(
                color: Palette.black.withOpacity(0.2),
                thickness: 1,
              ),
              DetailsItem(
                title: 'Wind',
                value: consolidatedWeather.windSpeed,
              ),
            ],
          ),
        )
      ],
    );
  }
}
