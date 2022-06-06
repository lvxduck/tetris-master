import 'package:flutter/material.dart';

class TetrisCard extends StatefulWidget {
  const TetrisCard({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final MaterialColor color;
  final Widget child;

  @override
  _TetrisCardState createState() => _TetrisCardState();
}

class _TetrisCardState extends State<TetrisCard> {
  var isHover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: widget.color[500],
        border: Border(
          top: BorderSide(color: widget.color[400]!, width: 2),
          bottom: BorderSide(color: widget.color[700]!, width: 2),
          left: BorderSide(color: widget.color[500]!, width: 2),
        ),
      ),
      child: widget.child,
    );
  }
}
