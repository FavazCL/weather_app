import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:weather_app/app/features/general_widgets/text_input_search.dart';
import 'package:weather_app/app/features/home/blocs/weather/weather_bloc.dart';
import 'package:weather_app/app/features/home/cubits/search/search_cubit.dart';

class FailurePage extends StatelessWidget {
  const FailurePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      backgroundColor: Palette.background,
      body: responsive.isPortrait
          ? const FailureViewPortrait()
          : const FailureViewLandscape(),
    );
  }
}

class FailureViewPortrait extends StatelessWidget {
  const FailureViewPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              LottieBuilder.asset(
                'assets/animations/empty.json',
                package: 'ui_kit',
              ),
              const Text(
                'Location not found, try again.',
                style: TextStyle(
                  fontSize: 18,
                  color: Palette.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextInputSearch(
                onChanged: (value) {
                  context.read<SearchCubit>().changeLocation(value);
                },
                onPressed: () {
                  context
                      .read<WeatherBloc>()
                      .add(WeatherRequested(state.location));
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class FailureViewLandscape extends StatelessWidget {
  const FailureViewLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    LottieBuilder.asset(
                      'assets/animations/empty.json',
                      package: 'ui_kit',
                    ),
                    
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Location not found, try again.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Palette.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextInputSearch(
                      onChanged: (value) {
                        context.read<SearchCubit>().changeLocation(value);
                      },
                      onPressed: () {
                        context
                            .read<WeatherBloc>()
                            .add(WeatherRequested(state.location));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
