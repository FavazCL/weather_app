import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:weather_app/app/features/general_widgets/loading.dart';
import 'package:weather_app/app/features/home/blocs/weather/weather_bloc.dart';
import 'package:weather_app/app/features/home/cubits/search/search_cubit.dart';
import 'package:weather_app/app/features/home/view/details.dart';
import 'package:weather_app/app/features/home/view/home_footer.dart';
import 'package:weather_app/app/features/home/view/home_header.dart';
import 'package:weather_app/app/features/home/view/input_search.dart';
import 'package:weather_app/app/features/home/view/local_widgets/failure_page.dart';
import 'package:weather_app/app/features/home/view/local_widgets/unit_widget.dart';
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
        body: SingleChildScrollView(
          child: SizedBox(
            height: responsive.height,
            child: responsive.isPortrait
                ? const HomeViewPortrait()
                : const HomeViewLandscape(),
          ),
        ),
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
    final responsive = Responsive.of(context);

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
                          padding: EdgeInsets.symmetric(
                            vertical: responsive.hp(1),
                            horizontal: responsive.wp(2),
                          ),
                          child: Row(
                            children: [
                              const Flexible(child: InputSearch()),
                              SizedBox(width: responsive.wp(2)),
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
                        SizedBox(height: responsive.hp(2)),
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
                        SizedBox(height: responsive.hp(2)),
                        Expanded(
                          flex: 2,
                          child: HomeFooter(
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
    final responsive = Responsive.of(context);

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
                if (state.status == WeatherStatus.success ||
                    state.weather != null)
                  SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: responsive.hp(2),
                            horizontal: responsive.wp(2),
                          ),
                          child: Row(
                            children: [
                              const Flexible(child: InputSearch()),
                              SizedBox(width: responsive.wp(1)),
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
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(width: responsive.wp(4)),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    HomeHeader(
                                      date: state
                                          .currentConsolidated!.applicableDate,
                                      location: state.weather!.title,
                                      temperature:
                                          state.currentConsolidated!.theTemp,
                                      isCelsius: state.isCelsius,
                                    ),
                                    SizedBox(height: responsive.hp(1)),
                                    AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      child: Details(
                                        key: ValueKey(
                                          state.currentConsolidated!.id,
                                        ),
                                        consolidatedWeather:
                                            state.currentConsolidated!,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: responsive.wp(4)),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: responsive.hp(2),
                                    right: responsive.wp(2),
                                  ),
                                  child: HomeFooter(
                                    weathers:
                                        state.weather!.consolidatedWeather,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
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
