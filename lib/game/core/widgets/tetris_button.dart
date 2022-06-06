import 'package:flutter/material.dart';

class TetrisButton extends StatefulWidget {
  const TetrisButton({
    Key? key,
    required this.color,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final MaterialColor color;
  final VoidCallback onTap;
  final Widget child;

  @override
  _TetrisButtonState createState() => _TetrisButtonState();
}

class _TetrisButtonState extends State<TetrisButton> {
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
          child: widget.child,
        ),
      ),
    );
  }
}
