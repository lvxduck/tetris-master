import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({
    Key? key,
    required this.color,
    this.child,
    required this.size,
  }) : super(key: key);

  final double size;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    const padding = 1.0;
    return Container(
      margin: const EdgeInsets.all(padding),
      width: size - padding * 2,
      height: size - padding * 2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
      child: child,
    );
  }
}
