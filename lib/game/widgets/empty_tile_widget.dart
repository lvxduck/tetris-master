import 'package:flutter/material.dart';

class EmptyTileWidget extends StatelessWidget {
  const EmptyTileWidget({
    Key? key,
    required this.size,
  }) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
    );
  }
}
