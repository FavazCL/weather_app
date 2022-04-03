import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TextInputSearch extends StatelessWidget {
  const TextInputSearch({
    Key? key,
    required this.onChanged,
    required this.onPressed,
  }) : super(key: key);

  final Function(String) onChanged;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      onChanged: onChanged,
      textCapitalization: TextCapitalization.sentences,
      onEditingComplete: () {},
      onFieldSubmitted: (_) => onPressed(),
      decoration: InputDecoration(
        filled: true,
        isCollapsed: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          onPressed: onPressed,
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
    );
  }
}
