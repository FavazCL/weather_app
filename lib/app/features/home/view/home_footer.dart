import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:weather_api/weather_api.dart' show ConsolidatedWeather;
import 'package:weather_app/app/features/home/blocs/weather/weather_bloc.dart';
import 'package:weather_app/app/features/home/view/weather_item.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({Key? key, required this.weathers}) : super(key: key);

  final List<ConsolidatedWeather> weathers;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return responsive.isPortrait
        ? HomeFooterPortrait(weathers: weathers)
        : HomeFooterLandscape(weathers: weathers);
  }
}

class HomeFooterPortrait extends StatelessWidget {
  const HomeFooterPortrait({
    Key? key,
    required this.weathers,
  }) : super(key: key);

  final List<ConsolidatedWeather> weathers;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: Palette.purple,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: responsive.hp(2)),
          Text(
            'Forecast for the next few days',
            style: TextStyle(fontSize: responsive.dp(1.6), color: Colors.white),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: responsive.hp(2)),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: weathers.length,
                itemBuilder: (context, index) {
                  final currentWeather = weathers[index];

                  return WeatherItem(
                    weather: currentWeather,
                    isToday: index == 0,
                    onTap: () {
                      context
                          .read<WeatherBloc>()
                          .add(CurrentWeatherChanged(currentWeather.id));
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeFooterLandscape extends StatelessWidget {
  const HomeFooterLandscape({
    Key? key,
    required this.weathers,
  }) : super(key: key);

  final List<ConsolidatedWeather> weathers;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: responsive.hp(4)),
      padding: EdgeInsets.symmetric(
        vertical: responsive.hp(2),
        horizontal: responsive.wp(1),
      ),
      decoration: const BoxDecoration(
        color: Palette.purple,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: responsive.hp(2)),
          Text(
            'Forecast for the next few days',
            style: TextStyle(fontSize: responsive.dp(1.6), color: Colors.white),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: responsive.hp(2)),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: weathers.length,
                itemBuilder: (context, index) {
                  final currentWeather = weathers[index];

                  return WeatherItem(
                    weather: currentWeather,
                    isToday: index == 0,
                    onTap: () {
                      context
                          .read<WeatherBloc>()
                          .add(CurrentWeatherChanged(currentWeather.id));
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
