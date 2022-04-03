import 'package:flutter/material.dart';

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
      onFieldSubmitted: (value) {},
      decoration: InputDecoration(
        filled: true,
        isCollapsed: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          onPressed: onPressed,
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
    );
  }
}
