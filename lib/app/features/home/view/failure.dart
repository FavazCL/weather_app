import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:weather_app/app/features/home/blocs/weather/weather_bloc.dart';
import 'package:weather_app/app/features/home/cubits/search/search_cubit.dart';

class Failure extends StatelessWidget {
  const Failure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Center(
      child: Container(
        height: responsive.height,
        color: Colors.black.withOpacity(0.2),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (value) {
                      context.read<SearchCubit>().changeLocation(value);
                    },
                    textCapitalization: TextCapitalization.sentences,
                    onEditingComplete: () {},
                    onFieldSubmitted: (value) {},
                    decoration: InputDecoration(
                      filled: true,
                      isCollapsed: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        onPressed: () {
                          context
                              .read<WeatherBloc>()
                              .add(WeatherRequested(state.location));
                        },
                        icon: const Icon(Icons.search),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: 'Enter a location',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
