import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:weather_app/app/features/home/blocs/weather/weather_bloc.dart';
import 'package:weather_app/app/features/home/cubits/search/search_cubit.dart';

class InputSearch extends StatefulWidget {
  const InputSearch({Key? key}) : super(key: key);

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch>
    with SingleTickerProviderStateMixin {
  late TextEditingController textEditingController;
  late AnimationController animationController;
  late Animation<double> sizeFactor;

  @override
  void initState() {
    super.initState();
    initializeConfigurations();
  }

  void initializeConfigurations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    sizeFactor = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );

    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Row(
          children: [
            ContainerBase(
              child: IconButton(
                onPressed: () {
                  if (!state.displaySearch) {
                    animationController.forward();
                  } else {
                    animationController.reverse();
                  }

                  context.read<SearchCubit>().toggleSearch();
                },
                icon: Icon(state.displaySearch ? Icons.close : Icons.search),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: sizeFactor,
                child: TextFormField(
                  controller: textEditingController,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (value) {
                    context.read<SearchCubit>().changeLocation(value);
                  },
                  textCapitalization: TextCapitalization.sentences,
                  onEditingComplete: () {},
                  onFieldSubmitted: (_) {
                    context
                        .read<WeatherBloc>()
                        .add(WeatherRequested(state.location));

                    context.read<SearchCubit>().toggleSearch();
                    animationController.reverse();
                    textEditingController = TextEditingController();
                    currentFocus.unfocus();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    isCollapsed: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      onPressed: () {
                        context
                            .read<WeatherBloc>()
                            .add(WeatherRequested(state.location));

                        context.read<SearchCubit>().toggleSearch();
                        animationController.reverse();
                        textEditingController = TextEditingController();
                        currentFocus.unfocus();
                      },
                      icon: const Icon(Icons.search),
                    ),
                    contentPadding: const EdgeInsets.only(left: 10),
                    hintText: 'Berlin',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Palette.background,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.purpleLight),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.background),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
