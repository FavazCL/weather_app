import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:weather_app/app/features/home/blocs/weather/weather_bloc.dart';
import 'package:weather_app/app/features/home/cubits/search/search_cubit.dart';
import 'package:weather_app/app/features/home/view/input_search.dart';
import 'package:weather_repository/weather_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => WeatherBloc(
                  weatherRepository: context.read<WeatherRepository>(),
                )..add(const WeatherRequested('london'))),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state.status == WeatherStatus.loading) {
            return Container(height: 100, color: Colors.red);
          } else if (state.status == WeatherStatus.success) {
            return SafeArea(
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
                  Header(
                    date: state.currentConsolidated!.applicableDate,
                    location: state.weather!.title,
                  ),
                  const SizedBox(height: 20),
                  const Details(),
                  const SizedBox(height: 20),
                  const Expanded(child: Footer()),
                ],
              ),
            );
          }

          return Container(height: 100, color: Colors.blue);
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
  }) : super(key: key);

  final String location;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          date.toString(),
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
        )
      ],
    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutterLogo(size: 200),
        const SizedBox(height: 10),
        Text(
          'Cloudy',
          style: TextStyle(
              fontSize: 40, color: Palette.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DetailsItem(),
            DetailsItem(),
            DetailsItem(),
          ],
        )
      ],
    );
  }
}

class DetailsItem extends StatelessWidget {
  const DetailsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Wind',
          style: TextStyle(fontSize: 14, color: Palette.black),
        ),
        const SizedBox(height: 5),
        Text(
          '200',
          style: TextStyle(
              fontSize: 24, color: Palette.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Palette.purple,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            FooterItem(),
          ],
        ),
      ),
    );
  }
}

class FooterItem extends StatelessWidget {
  const FooterItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Palette.purpleLight,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlutterLogo(),
            const SizedBox(height: 10),
            Text(
              '12:00',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              '35C',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
