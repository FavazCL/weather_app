import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:weather_api/weather_api.dart' show ConsolidatedWeather;
import 'package:weather_app/app/features/general_widgets/loading.dart';
import 'package:weather_app/app/features/home/blocs/weather/weather_bloc.dart';
import 'package:weather_app/app/features/home/cubits/search/search_cubit.dart';
import 'package:weather_app/app/features/home/view/details.dart';
import 'package:weather_app/app/features/home/view/home_header.dart';
import 'package:weather_app/app/features/home/view/input_search.dart';
import 'package:weather_app/app/features/home/view/local_widgets/failure_page.dart';
import 'package:weather_app/app/features/home/view/local_widgets/unit_widget.dart';
import 'package:weather_app/app/features/home/view/weather_item.dart';
import 'package:weather_repository/weather_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.location}) : super(key: key);

  final String location;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(
            weatherRepository: context.read<WeatherRepository>(),
          )..add(WeatherRequested(location)),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Palette.background,
        body: responsive.isPortrait
            ? const HomeViewPortrait()
            : const HomeViewLandscape(),
      ),
    );
  }
}

class HomeViewPortrait extends StatefulWidget {
  const HomeViewPortrait({Key? key}) : super(key: key);

  @override
  State<HomeViewPortrait> createState() => _HomeViewPortraitState();
}

class _HomeViewPortraitState extends State<HomeViewPortrait> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return SafeArea(
          bottom: false,
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              final location = context.read<SearchCubit>().state.location;
              context.read<WeatherBloc>().add(WeatherRequested(location));
              _refreshController.refreshCompleted();
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
                              UnitWidget(
                                isCelsius: state.isCelsius,
                                onPressed: () {
                                  context
                                      .read<WeatherBloc>()
                                      .add(const UnitChanged());
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        HomeHeader(
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
                if (state.status == WeatherStatus.failure) const FailurePage(),
                if (state.status == WeatherStatus.loading) const Loading()
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeViewLandscape extends StatefulWidget {
  const HomeViewLandscape({Key? key}) : super(key: key);

  @override
  State<HomeViewLandscape> createState() => _HomeViewLandscapeState();
}

class _HomeViewLandscapeState extends State<HomeViewLandscape> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return SafeArea(
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              final location = context.read<SearchCubit>().state.location;
              context.read<WeatherBloc>().add(WeatherRequested(location));
              _refreshController.refreshCompleted();
            },
            child: Stack(
              children: [
                if (state.status == WeatherStatus.failure) const FailurePage(),
                if (state.status == WeatherStatus.loading) const Loading()
              ],
            ),
          ),
        );
      },
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
                _refreshController.refreshCompleted();
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
                                UnitWidget(
                                  isCelsius: state.isCelsius,
                                  onPressed: () {
                                    context
                                        .read<WeatherBloc>()
                                        .add(const UnitChanged());
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          HomeHeader(
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
                  if (state.status == WeatherStatus.failure) const FailurePage(),
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
