import 'package:flutter/material.dart';
import 'package:tetris_master/game/core/widgets/tetris_button.dart';

class TetrisModeButton extends StatefulWidget {
  const TetrisModeButton({
    Key? key,
    required this.color,
    required this.type,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  final MaterialColor color;
  final String type;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  _TetrisModeButtonState createState() => _TetrisModeButtonState();
}

class _TetrisModeButtonState extends State<TetrisModeButton> {
  var isHover = false;

  @override
  Widget build(BuildContext context) {
    return TetrisButton(
      color: widget.color,
      onTap: widget.onTap,
      child: Row(
        children: [
          Text(
            widget.type,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: widget.color[200],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 16, color: widget.color[100]),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 11, color: widget.color[300]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
