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
          const SizedBox(height: 20),
          const Text(
            'Next days',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40),
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
