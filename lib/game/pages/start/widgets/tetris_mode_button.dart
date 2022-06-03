import 'package:flutter/material.dart';

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
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(left: isHover ? 0 : 32),
      child: InkWell(
        onTap: widget.onTap,
        onHover: (isHover) {
          setState(() {
            this.isHover = isHover;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.color[600],
            border: Border(
              top: BorderSide(color: widget.color[400]!, width: 2),
              bottom: BorderSide(color: widget.color[700]!, width: 2),
              left: BorderSide(color: widget.color[500]!, width: 2),
            ),
          ),
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
        ),
      ),
    );
  }
}
