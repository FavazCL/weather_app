import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:utils/utils.dart';
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
    final responsive = Responsive.of(context);

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: responsive.wp(4)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                'assets/animations/empty.json',
                package: PackageName.uiKit,
              ),
              SizedBox(height: responsive.hp(4)),
              Text(
                'Location not found, try again.',
                style: TextStyle(
                  fontSize: responsive.dp(2),
                  color: Palette.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: responsive.hp(4)),
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
              SizedBox(height: responsive.hp(4)),
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
        final responsive = Responsive.of(context);

        return Container(
          padding: EdgeInsets.symmetric(horizontal: responsive.wp(4)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      'assets/animations/empty.json',
                      package: PackageName.uiKit,
                    ),
                  ],
                ),
              ),
              SizedBox(width: responsive.wp(4)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Location not found, try again.',
                      style: TextStyle(
                        fontSize: responsive.dp(2),
                        color: Palette.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: responsive.hp(4)),
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
