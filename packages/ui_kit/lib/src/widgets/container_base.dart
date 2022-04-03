import 'package:flutter/material.dart';

/// The [ContainerBase] class
class ContainerBase extends StatelessWidget {
  /// Constructor of the [ContainerBase] class
  const ContainerBase({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// [ContainerBase] that will be wrap for this [Widget]
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
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: child,
    );
  }
}
