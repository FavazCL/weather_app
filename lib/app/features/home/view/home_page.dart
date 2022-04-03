import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:utils/utils.dart';
import 'package:weather_api/weather_api.dart' show ConsolidatedWeather;
import 'package:weather_app/app/features/home/blocs/weather/weather_bloc.dart';
import 'package:weather_app/app/features/home/cubits/search/search_cubit.dart';
import 'package:weather_app/app/features/home/view/failure.dart';
import 'package:weather_app/app/features/home/view/input_search.dart';
import 'package:weather_app/app/features/home/view/loading.dart';
import 'package:weather_repository/weather_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.location}) : super(key: key);

  final String location;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(
            weatherRepository: context.read<WeatherRepository>(),
          )..add(
              const WeatherRequested('berlin'),
            ),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return SafeArea(
            bottom: false,
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                final location = context.read<SearchCubit>().state.location;
                context.read<WeatherBloc>().add(WeatherRequested(location));
              },
              child: Stack(
                children: [
                  if (state.status == WeatherStatus.success ||
                      state.weather != null)
                    SafeArea(
                      bottom: false,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Row(
                              children: [
                                const Flexible(child: InputSearch()),
                                const SizedBox(width: 10),
                                ContainerBase(
                                  child: IconButton(
                                    onPressed: () {
                                      context
                                          .read<WeatherBloc>()
                                          .add(const UnitChanged());
                                    },
                                    icon: Image.asset(
                                      state.isCelsius
                                          ? 'assets/images/celsius.png'
                                          : 'assets/images/farenheit.png',
                                      package: 'ui_kit',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Header(
                            date: state.currentConsolidated!.applicableDate,
                            location: state.weather!.title,
                            temperature: state.currentConsolidated!.theTemp,
                            isCelsius: state.isCelsius,
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Details(
                              key: ValueKey(state.currentConsolidated!.id),
                              consolidatedWeather: state.currentConsolidated!,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Expanded(
                            flex: 2,
                            child: Footer(
                              weathers: state.weather!.consolidatedWeather,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (state.status == WeatherStatus.failure) const Failure(),
                  if (state.status == WeatherStatus.loading) const Loading()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
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

class Details extends StatelessWidget {
  const Details({Key? key, required this.consolidatedWeather})
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

class DetailsItem extends StatelessWidget {
  const DetailsItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final num value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Palette.black),
        ),
        const SizedBox(height: 5),
        Text(
          '${value.toInt()}',
          style: const TextStyle(
            fontSize: 24,
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key, required this.weathers}) : super(key: key);

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

                  return FooterItem(
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

class FooterItem extends StatelessWidget {
  const FooterItem({
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
              const SizedBox(height: 10),
              const FlutterLogo(),
              const SizedBox(height: 10),
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
