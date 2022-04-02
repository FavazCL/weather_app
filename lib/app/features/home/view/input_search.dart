import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:weather_app/app/features/home/cubits/search/search_cubit.dart';

class InputSearch extends StatefulWidget {
  const InputSearch({Key? key}) : super(key: key);

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> sizeFactor;

  @override
  void initState() {
    super.initState();
    initializeAnimation();
  }

  void initializeAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    sizeFactor = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                icon: Icon(state.displaySearch ?  Icons.close : Icons.search),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: sizeFactor,
                child: TextFormField(
                  onChanged: (value) {},
                  textCapitalization: TextCapitalization.sentences,
                  onEditingComplete: () {},
                  onFieldSubmitted: (value) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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
                  validator: (val) {},
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
