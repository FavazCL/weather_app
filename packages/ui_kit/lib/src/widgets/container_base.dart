import 'package:flutter/material.dart';

class ContainerBase extends StatelessWidget {
  const ContainerBase({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            offset: Offset(1,1)
          )
        ]
      ),
      child: child,
    );
  }
}
